cd docs/.vuepress/dist
git init
git add .
# git checkout -b gh-pages

#  把dist 发布到新分支

# 配置git
git config user.name veaba

# 抛出错误
set -e 
git commit -m "[Deploy sucess]：`date`"
# git remote add origin git@github.com:veaba/vuepress.git
# git push -f git@github.com:veaba/vuepress.git master:gh-pages
git push -f "https://${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages"

echo "漂亮！部署成功： `date`"