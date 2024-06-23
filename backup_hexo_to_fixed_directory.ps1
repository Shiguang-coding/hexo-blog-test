param (
    [alias("o")]
    [switch]$overwrite = $false
)

# 设置PowerShell的输出编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 设置Hexo博客源码目录
$HEXO_SOURCE_DIR = "D:\hexo\hexo-blog-test\blog"

# 设置备份目录
$BACKUP_DIR = "D:\Workspace\shiguang-coding\hexo-blog-test"

# 输出开始备份的提示信息
Write-Host "Starting Hexo blog source backup..."

# 检查备份目录是否存在
if (Test-Path -Path $BACKUP_DIR) {
    if ($overwrite) {
        # 覆盖同名文件，但不删除原有文件
        Write-Host "Overwriting existing files in backup directory..."
        Get-ChildItem -Path $HEXO_SOURCE_DIR -Recurse | ForEach-Object {
            if ($_.Name -ne ".gitignore") {
                $destinationPath = Join-Path -Path $BACKUP_DIR -ChildPath $_.FullName.Substring($HEXO_SOURCE_DIR.Length + 1)
                if (Test-Path -Path $destinationPath) {
                    Remove-Item -Path $destinationPath -Force -Recurse
                }
                Copy-Item -Path $_.FullName -Destination $destinationPath -Force
            } else {
                Write-Host "Ignoring file: $($_.FullName)"
            }
        }
    } else {
        Write-Host "Backup directory already exists. Use -o parameter to overwrite it."
        exit
    }
} else {
    # 创建备份目录
    Write-Host "Creating backup directory: $BACKUP_DIR"
    New-Item -ItemType Directory -Path $BACKUP_DIR -Force

    # 复制Hexo博客源码到备份目录
    Write-Host "Copying Hexo blog source to backup directory..."
    Get-ChildItem -Path $HEXO_SOURCE_DIR -Recurse | ForEach-Object {
        if ($_.Name -ne ".gitignore") {
            $destinationPath = Join-Path -Path $BACKUP_DIR -ChildPath $_.FullName.Substring($HEXO_SOURCE_DIR.Length + 1)
            Copy-Item -Path $_.FullName -Destination $destinationPath -Force
        } else {
            Write-Host "Ignoring file: $($_.FullName)"
        }
    }
}

# 检查复制是否成功
if ($?) {
    Write-Host "Backup successful: $BACKUP_DIR"
} else {
    Write-Host "Backup failed"
}