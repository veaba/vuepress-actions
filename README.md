# vuepress
vuepress部署测试

> 发现是deploy access token 没配置好

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
      - name: 步骤：第一步 Use Node.js ${{ matrix.node-version }}
        uses: actions/setup-node@v1
        with:
          node-version: ${{ matrix.node-version }}
      - name: 步骤：第二步，安装依赖
        run: |
          npm install
          npm run build --if-present
        env:
          CI: true
      # - name: 步骤：第三步（deplpy：deploy/build.sh）
      #   env:
      #     ACCESS_TOKEN_DEPLOY: ${{secrets.ACTIONS_ACCESS_TOKEN_VUEPRESS__CI }}
      #   run: |
      #     sh deploy/build.sh
      - name: 步骤：第三步：Deploy,部署
        uses: peaceiris/actions-gh-pages@v2.5.0
        env:
          ACTIONS_DEPLOY_KEY: ${{ secrets.ACTIONS_ACCESS_TOKEN_VUEPRESS_CI }}
          PUBLISH_BRANCH: gh-pages
          PUBLISH_DIR: ./docs/.vuepress/dist
```