# 获取脚本所在目录
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path

# 设置Git仓库路径为脚本所在目录
$repoPath = $scriptPath

# 切换到Git仓库目录
Set-Location -Path $repoPath

# 检查是否有未提交的更改
$status = git status --porcelain

if ($status) {
    # 有未提交的更改
    Write-Host "Uncommitted changes detected. Proceeding with commit..."

    # 添加所有更改到暂存区
    git add .
    Write-Host "Changes added to staging area."

    # 获取当前时间
    $currentTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $commitMessage = "Auto commit at $currentTime"

    # 提交更改
    git commit -m $commitMessage
    Write-Host "Changes committed with message: $commitMessage"

    # 推送到远程仓库
    git push origin main
    Write-Host "Changes pushed to remote repository."
} else {
    # 没有未提交的更改
    Write-Host "No changes to commit."
}

Write-Host "Git operations completed."