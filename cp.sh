#!/bin/bash  
 
# 目标目录的根路径  
REPO_DIR=$(dirname $(realpath $0))
DATA_DIR="../spark-store-project.github.io"  
if [ ! -e "$DATA_DIR" ];then
mkdir -p $DATA_DIR
fi

function sync_file(){

######阶段1：检查target_root目录下的对应文件文件，去仓库验证是否有对应的文件
######如果有，则对比时间戳，若仓库的新，则更新，否则continue
######如果没有，则删除此文件

cd $DATA_DIR
find . -type f -name "$1" | while read -r DEB_PACKAGE_INFO_PATH; do  

DEB_PATH=`echo "$REPO_DIR/${DEB_PACKAGE_INFO_PATH}"` 


if [ -e $DEB_PATH ];then
	if [ "$DEB_PACKAGE_INFO_PATH"  -ot "$DEB_PATH" ] ;then
		###时间戳校验
		echo "$DEB_PATH同步后发生了改变，将重新同步"
		rm  $DEB_PACKAGE_INFO_PATH
	fi

else

rm -v $DEB_PACKAGE_INFO_PATH
#####删除已下架的包

fi
done




##### 阶段2：反查deb，如果有.deb.package，则跳过，否则生成
cd $REPO_DIR
find . -type f -name "$1" | while read -r DEB_PATH; do  

if [ -e $DATA_DIR/$DEB_PATH ];then
continue

else
mkdir -p $DATA_DIR/`dirname $DEB_PATH`
cp -v $DEB_PATH  $DATA_DIR/$DEB_PATH

fi
done
#####删除data目录下所有空文件夹

find $DATA_DIR -type d -empty -exec rm -rf {} \;
echo "$1 文件已按目录结构同步完成。"
}
sync_file '*.json'
sync_file '*.html' 
sync_file '*.css' 
sync_file '*.js' 
sync_file '*.metalink' 
sync_file 'Packages' 
sync_file 'Release' 
sync_file 'InRelease' 
sync_file '*.png' 
sync_file '*.conf' 
sync_file '*.list' 
sync_file '*.zip' 
sync_file '*.txt' 
