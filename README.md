# vuepress

Vuepress生成文件时候，会被public里面的文件改写为小写，而如果自定义域名的话是一个叫`CNAME`的文件，会被小写覆盖，导致每次都要在设置里面重新设置一遍自定义域名，所以这里使用了自己的脚本来发布Vuepress项目，以更灵活的定制

## 生成ssh添加deploy token

```shell
 ssh-keygen -t rsa -b 4096 -C "your@email.com" -f gh-pages -N ""
 # gh-pages.pub 公钥
 # gh-pages 私钥
```

Deploy key 添加公钥

Secrets 添加私钥



## 关于本项目使用的Actions

```yml
name: Vuepress CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        node-version: [12.x]

    steps:
      - uses: actions/checkout@v1
      - name: 步骤：第一步 -> Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v1
        with:
          node-version: ${{ matrix.node-version }}

      - name: 步骤：第二步 -> 安装依赖
        run: |
          npm install
          npm run build
        env:
          CI: true

      - name: 步骤：第三步 -> 使用脚本部署
        env:
          ACCESS_TOKEN_DEPLOY: ${{secrets.ACTIONS_ACCESS_TOKEN_VUEPRESS_CI }}
          PUBLISH_BRANCH: gh-pages
          PUBLISH_DIR: ./docs/.vuepress/dist
        run: |
          chmod +x deploy/build.sh
          bash deploy/build.sh

```

## 脚本如下

```shell
# !/bin/bash
set -e
# 检查Actions目录配置
if [ -z "${PUBLISH_DIR}" ]; then
    echo "【致命错误】：workflows尚未设置 PUBLISH_DIR"
    exit 1
fi

# 检查设置的目录是否存在，不存在直接退出
if [ -d "$(pwd)${PUBLISH_DIR}" ]; then
    echo "【致命错误】：PUBLISH_DIR 尚未生成"
    exit 1
fi

# 检查要发布的分支名称
if [ -z "${PUBLISH_BRANCH}" ]; then
    print_error "【致命错误】：没有发现 PUBLISH_BRANCH"
    exit 1
fi

# 进入到build的目录
cd "${PUBLISH_DIR}" # ./docs/.vuepress/dist

# 为gh-pages 生成CNAME，发现使用别人提供的脚本，生成的竟然是小写的CNAME文件，所以改为小写的，使用脚本写入

echo "vue.datav.ai" >CNAME

# 格式化的输出
function print_error() {
    echo -e "\e[31mERROR: ${1}\e[m"
}

function print_info() {
    echo -e "\e[36mINFO: ${1}\e[m"
}

# 配置仓库地址
if [ -n "${EXTERNAL_REPOSITORY}" ]; then
    PUBLISH_REPOSITORY=${EXTERNAL_REPOSITORY}
else
    PUBLISH_REPOSITORY=${GITHUB_REPOSITORY}
fi

# 配置ssh
if [ -n "${ACCESS_TOKEN_DEPLOY}" ]; then
    echo "设置 ACCESS_TOKEN_DEPLOY"
    SSH_DIR="${HOME}/.ssh"
    # SSH_DIR="/root/.ssh"
    mkdir "${SSH_DIR}"
    ssh-keyscan -t rsa github.com >"${SSH_DIR}/known_hosts"
    echo "${ACCESS_TOKEN_DEPLOY}" >"${SSH_DIR}/id_rsa"
    chmod 400 "${SSH_DIR}/id_rsa"
    remote_repo="git@github.com:${PUBLISH_REPOSITORY}.git"
fi

# 跳过配置personal_token 和 github_token
remote_branch="${PUBLISH_BRANCH}"

# 配置git
git init
git checkout --orphan "${remote_branch}" # 积累无数次commit，不算分支

git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"

git remote rm origin || true
git remote add origin "${remote_repo}"

# git提交
git add .
git commit -m "[Deploy sucess]：$(date)"

# 查看branch
echo "查看分支：\ $(git branch -v)"
echo "查看remote：\ $(git remote -v)"
echo "查看仓库地址：\ ${remote_repo}"
echo "查看PUBLISH_REPOSITORY：\ ${PUBLISH_REPOSITORY}"

git push origin -f "${PUBLISH_BRANCH}"

print_info "${GITHUB_SHA} 漂亮！部署成功： $(date)"

```