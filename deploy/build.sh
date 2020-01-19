# !/bin/bash
# 检查Actions目录配置
if [ -z "${PUBLISH_DIR}" ]; then
    echo "错误：workflows尚未设置 PUBLISH_DIR"
    exit 1
fi

# 检查设置的目录是否存在，不存在直接退出
if [ -d "${PUBLISH_DIR}" ]; then
    echo "错误：PUBLISH_DIR 尚未生成"
    exit 1
fi

cd "${PUBLISH_DIR}"

echo $(pwd)
echo $(ls)

function print_error() {
    echo -e "\e[31mERROR: ${1}\e[m"
}
# 配置仓库地址
if [ -n "${EXTERNAL_REPOSITORY}" ]; then
    PUBLISH_REPOSITORY=${EXTERNAL_REPOSITORY}
else
    PUBLISH_REPOSITORY=${GITHUB_REPOSITORY}
fi
# 配置ssh
if [ -n "${DEPLOY_ACCESS_TOKEN}"]; then
    echo "设置 DEPLOY_ACCESS_TOKEN"
    if [ -n "${SCRIPT_MODE}"]; then
        echo "模式：SCRIPT MODE"
        SSH_DIR="{HOME}/.ssh"
    else
        SSH_DIR="/root/.ssh"
    fi
    mkdir "${SSH_DIR}"
    ssh-keyscan -t rsa github.com >"${SSH_DIR}/known_hosts"
    echo "${DEPLOY_ACCESS_TOKEN}" >"${SSH_DIR}/id_rsa"
    chmod 400 "${SSH_DIR}/id_rsa"

    remote_repo="git@github.com:${PUBLISH_REPOSITORY}.git"
fi
# 检查要发布的脚本
if [ -z "${PUBLISH_BRANCH}"]; then
    print_error "致命错误：没有发现 PUBLISH_BRANCH"
    exit 1
fi
# 跳过配置personal_token 和 github_token
remote_branch="${PUBLISH_BRANCH}"

# 配置git
git config user.name "${GITHUB_ACTOR}"
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git remote rm origin || true

# git提交
git add .
git commit -m "[Deploy sucess]：$(date)"

# git remote add origin https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git

# 抛出错误
set -e

# 用echo 拼装，否则会无效！！测试了上百次的结果,access token 会被过滤
# echo "`git push -f https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages`"

echo $(git push -f https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages)

# echo "git push -f origin master:gh-pages"
# echo "git push -f https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages"

echo "漂亮！部署成功： $(date)"
