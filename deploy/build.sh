cd docs/.vuepress/dist
git init

# 配置git
git config --global user.name "veaba"
git config --global user.email "908662421@qq.com"

# git提交
git add .
git commit -m "[Deploy sucess]：`date`"

# 抛出错误
set -e 

# 用echo 拼装，否则会无效！！测试了上百次的结果
echo "`git push -f https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git master:gh-pages`"
# git push -f "https://veaba:${ACCESS_TOKEN_PUSH}@github.com/veaba/vuepress.git" master:gh-pages

echo "漂亮！部署成功： `date`"