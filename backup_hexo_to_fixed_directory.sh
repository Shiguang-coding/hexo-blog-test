#!/bin/bash

# 设置输出编码为UTF-8
export LANG=en_US.UTF-8

# 设置Hexo博客源码目录
HEXO_SOURCE_DIR="D:/hexo/hexo-blog-test/blog"

# 设置备份目录
BACKUP_DIR="D:/Workspace/shiguang-coding/hexo-blog-test"

# 检查是否需要覆盖
OVERWRITE=false
if [[ "$1" == "-o" ]]; then
    OVERWRITE=true
fi

# 输出开始备份的提示信息
echo "Starting Hexo blog source backup..."

# 检查备份目录是否存在
if [ -d "$BACKUP_DIR" ]; then
    if [ "$OVERWRITE" = true ]; then
        # 覆盖同名文件，但不删除原有文件
        echo "Overwriting existing files in backup directory..."
        find "$HEXO_SOURCE_DIR" -type f -not -name ".gitignore" | while read -r file; do
            relative_path=${file#$HEXO_SOURCE_DIR/}
            destination_path="$BACKUP_DIR/$relative_path"
            if [ -e "$destination_path" ]; then
                rm -rf "$destination_path"
            fi
            mkdir -p "$(dirname "$destination_path")"
            cp "$file" "$destination_path"
        done
    else
        echo "Backup directory already exists. Use -o parameter to overwrite it."
        exit 1
    fi
else
    # 创建备份目录
    echo "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    # 复制Hexo博客源码到备份目录
    echo "Copying Hexo blog source to backup directory..."
    find "$HEXO_SOURCE_DIR" -type f -not -name ".gitignore" | while read -r file; do
        relative_path=${file#$HEXO_SOURCE_DIR/}
        destination_path="$BACKUP_DIR/$relative_path"
        mkdir -p "$(dirname "$destination_path")"
        cp "$file" "$destination_path"
    done
fi

# 检查复制是否成功
if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_DIR"
else
    echo "Backup failed"
fi