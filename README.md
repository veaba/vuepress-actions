# vuepress

![Vuepress CI](https://github.com/veaba/vuepress-actions/workflows/Vuepress%20CI/badge.svg)

一个简单的 vuepres 项目部署工具，[Marketplace Actions Release Vuepress docs](https://github.com/marketplace/actions/release-vuepress-docs)

```yaml
- name: Release Vuepress docs
  uses: veaba/vuepress-actions@v0.83
```

## Usage
### Generate deploy token

```shell
 ssh-keygen -t rsa -b 4096 -C "your@email.com" -f gh-pages -N ""
 # gh-pages.pub 公钥
 # gh-pages 私钥
```

### Setting ssh key 

**Deploy key 添加公钥**：

在你的 `Repo` 中，找到 `setting`，在左侧 `Deploy keys` ，起个名字，将 `gh-pages.pub` 复制进去。

**Secrets 添加私钥**：

在你的 `Repo` 中，找到 `setting`，在左侧 `Secrets`，起个名字，如 `ACCESS_TOKEN`，将 `gh-pages.pub` 复制进去。

**记住这个名字：`ACCESS_TOKEN`**，务必与 `env.ACCESS_TOKEN_DEPLOY` 保持一致，见后面给出的范例

### Add Github Action

[范例](https://github.com/veaba/deno-docs/blob/master/.github/workflows/release.yml)：

```yml
name: release docs CI

on: 
  push:
    branches:
      - master

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
          ACCESS_TOKEN_DEPLOY: ${{secrets.ACCESS_TOKEN }}
          PUBLISH_BRANCH: gh-pages
          PUBLISH_DIR: ./docs/.vuepress/dist
          CNAME: deno.datav.ai
        uses: veaba/vuepress-actions@v0.83 
```

注意，为了确保获得功能正常，请始终使用最新版：

- `veaba/vuepress-actions@v0.83` 这是一个预生产版本，它已经可以工作了，[参考 deno-docs](https://github.com/veaba/deno-docs/actions/runs/406004283)。

- `CNAME` 部分是用户自己配置的域名。

- 如果一切成功，将会在 Actions 中看到执行结果

- 同时，会在生成一个 `gh-pages` 分支

- 这个脚本是与 `vuepress`项目绑定的，请务必是一个正常的 `vuepress` 项目


## Options

- PUBLISH_BRANCH
- PUBLISH_DIR
- CNAME

用户见前述

