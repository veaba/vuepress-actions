cd docs/.vuepress/dist
git init

# 配置git
git config --global user.name "veaba"
git config --global user.email "908662421@qq.com"

# git提交
git add .
git commit -m "[Deploy sucess]：`date`"

# 设置remote
# git remote add origin "https://${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git"

# 查看此时的分支
git branch -v
git remote -v 

# 设置分支

# 抛出错误
set -e 

# git push -u "https://${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git gh-pages"
# git push -f "https://${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages"
# git push -f origin master:gh-pages
# git push -f "git@github.com/veaba"

# git push --set-upstream "https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git" master:gh-pages

git push -f https://veaba:3282d9cbd96858d942d24dfe314d21972c88adf1@github.com/veaba/vuepress.git master:gh-pages

echo "漂亮！部署成功： `date`"