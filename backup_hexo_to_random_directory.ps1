# 设置PowerShell的输出编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 设置Hexo博客源码目录
$HEXO_SOURCE_DIR = "D:\hexo\hexo-blog-test\blog"

# 设置备份目录
$BACKUP_DIR = "D:\Workspace\shiguang-coding\hexo-blog-test"

# 设置备份目录中的子目录名
$BACKUP_SUBDIR = "hexo_source_backup_" + (Get-Date -Format "yyyyMMddHHmmss")

# 输出开始备份的提示信息
Write-Host "Starting Hexo blog source backup..."

# 创建备份目录（如果不存在）
Write-Host "Creating backup directory: $BACKUP_DIR\$BACKUP_SUBDIR"
New-Item -ItemType Directory -Path "$BACKUP_DIR\$BACKUP_SUBDIR" -Force

# 复制Hexo博客源码到备份目录
Write-Host "Copying Hexo blog source to backup directory..."
Copy-Item -Path "$HEXO_SOURCE_DIR\*" -Destination "$BACKUP_DIR\$BACKUP_SUBDIR" -Recurse -Force

# 检查复制是否成功
if ($?) {
    Write-Host "Backup successful: $BACKUP_DIR\$BACKUP_SUBDIR"
} else {
    Write-Host "Backup failed"
}