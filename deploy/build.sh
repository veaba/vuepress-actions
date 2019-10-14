pwd 
ls
cd docs/.vuepress/dist
ls
git add .
git checkout -b gh-pages

#  把dist 发布到新分支

# 抛出错误
set -e 
git add .
git commit -m "[Deploy sucess]：`date`"
git push -f -git@githuba.com:veaba/vuepress.git  master:gh-pages

echo "漂亮！部署成功： `date`"