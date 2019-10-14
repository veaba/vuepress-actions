cd docs/.vuepress/dist
git init
git add .

# 配置git
git config --gloabl user.name "veaba"
git config --gloabel user.email "908662421@qq.com"

# 抛出错误
set -e 
git commit -m "[Deploy sucess]：`date`"
# git remote add origin git@github.com:veaba/vuepress.git
# git push -f git@github.com:veaba/vuepress.git master:gh-pages
git push -f --set-upstream "https://${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages"
# git push -f "https://${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages"

echo "漂亮！部署成功： `date`"