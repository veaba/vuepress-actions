# pwd 
# ls
# cd docs/.vuepress/dist
# ls
# git init
# git add .
# git checkout -b gh-pages

# #  把dist 发布到新分支

# # 配置git
# git config user.name veaba
# git config user.email 908662421@qq.com

# # 抛出错误
# set -e 
# git add .
# git commit -m "[Deploy sucess]：`date`"
# git remote add origin git@github.com:veaba/vuepress.git
# git push -f git@github.com:veaba/vuepress.git master:gh-pages
# git push -f "https://oauth2:${secrets.ACTIONS_ACCESS_TOKEN_VUEPRESS__CI}@github.com:veaba/vuepress.git master:gh-pages"
echo ${ACCESS_TOKEN}
echo "漂亮！部署成功： `date`"