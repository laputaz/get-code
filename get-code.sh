#!/bin/sh
# 新建文件夹
newDir(){
    mkdir $FLODER
    cd $FLODER
    touch README.md
}
# 建立文件夹
read -p '请输入文件夹名称:' -a FLODER 
while [ -z $FLODER ]
    do
    read -p '名称为空, 请重新输入:' -a FLODER
done
# 文件夹已存在
if [ -d $FLODER ]
    then
        read -p "文件夹已存在, 是否删除文件夹并重建？(y/n)" -n 1
        echo ''
        if [[ $REPLY =~ ^[Yy]$ ]]
            then
            rm -rf $FLODER
            else 
            exit
        fi
fi

newDir

# 仓库地址 http/ssh
read -p '请输入仓库地址:' -a URL
while [ -z $URL ]
    do
    read -p '地址为空, 请重新输入:' -a URL
done
while [[ ! $URL =~ ^(http)|(ssh)$ ]]
    do
    read -p '地址格式不正确, 请重新输入:' -a URL
done

# 仓库别名
read -p '请输入远程仓库别名 (默认为 origin):' -a NAME
if [ -z $NAME ]
    then
    NAME='origin'
fi

# 分支名
read -p '请输入分支名 (默认为 master) :' -a BRANCH
if [ -z $BRANCH ]
    then
    BRANCH='master'
fi

# pull
git init
git remote add $NAME $URL 
git checkout -b $BRANCH
git pull $NAME $BRANCH
git add .
git commit -m "add README.md"
git push $NAME $BRANCH