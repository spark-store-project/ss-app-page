#!/bin/bash  
  
# 目标目录的根路径  
target_root="../ss-app-page"  
if [ ! -e "$target_root" ];then
mkdir -p $target_root
fi
function sync_file(){
# 递归查找当前目录下的所有 .json 文件，并处理每个文件  
find . -type f -name "$1" | while read -r file; do  
    # 提取文件相对于当前目录的路径（不包括 .）  
    relative_path="${file#./}"  
      
    # 提取目录部分  
    dir_path=$(dirname "$relative_path")  
      
    # 在目标根目录下构建相应的目录结构  
    target_dir="$target_root/$dir_path"  
      
    # 如果目标目录不存在，则创建它  
    mkdir -p "$target_dir"  
      
    # 复制文件到目标目录  
    cp -vu "$file" "$target_dir/"  
      

done  
  
echo "$1 文件已按目录结构复制完成。"
}
sync_file '*.json' &
sync_file '*.html' &
sync_file '*.css' &
sync_file '*.js' &
sync_file '*.metalink' &
sync_file 'Packages' &
sync_file 'Release' &
sync_file 'InRelease' &
sync_file '*.png' &
sync_file '*.conf' &
sync_file '*.list' &
sync_file '*.zip' &
sync_files '*.txt' &
wait
