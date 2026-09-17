#!/bin/bash
# 星炽工作台推送到GitHub的自动化脚本
# 使用方法：./push-to-github.sh <你的GitHub Token>

set -e

# 配置
PROJECT_DIR="/Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench/cc-haha-main"
GITHUB_USER="SC0321"
REPO_NAME="xingchi-workbench"

# 检查参数
if [ $# -eq 0 ]; then
    echo "❌ 请提供GitHub Personal Access Token"
    echo "使用方法：$0 <你的GitHub Token>"
    echo ""
    echo "如何生成Token："
    echo "1. 访问 https://github.com/settings/tokens"
    echo "2. 点击 'Generate new token'"
    echo "3. 勾选 'repo' 权限"
    echo "4. 复制生成的token（以ghp_开头）"
    exit 1
fi

TOKEN=$1
REMOTE_URL="https://${GITHUB_USER}:${TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo "=== 星炽工作台推送到GitHub ==="
echo "用户: $GITHUB_USER"
echo "仓库: $REPO_NAME"
echo ""

# 1. 检查项目目录
echo "步骤1：检查项目目录..."
if [ ! -d "$PROJECT_DIR" ]; then
    echo "❌ 项目目录不存在: $PROJECT_DIR"
    exit 1
fi
cd "$PROJECT_DIR"
echo "✅ 项目目录存在"

# 2. 配置Git凭证
echo ""
echo "步骤2：配置Git凭证..."
git config --global credential.helper store
echo "https://${GITHUB_USER}:${TOKEN}@github.com" > ~/.git-credentials
echo "✅ Git凭证已配置"

# 3. 设置远程仓库
echo ""
echo "步骤3：设置远程仓库..."
if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$REMOTE_URL"
    echo "✅ 已更新远程仓库URL"
else
    git remote add origin "$REMOTE_URL"
    echo "✅ 已添加远程仓库"
fi

# 4. 检查仓库是否存在
echo ""
echo "步骤4：检查GitHub仓库..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token $TOKEN" \
    "https://api.github.com/repos/${GITHUB_USER}/${REPO_NAME}")

if [ "$HTTP_CODE" = "200" ]; then
    echo "✅ 仓库已存在"
elif [ "$HTTP_CODE" = "404" ]; then
    echo "⚠️  仓库不存在，正在创建..."
    curl -X POST https://api.github.com/user/repos \
        -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github+json" \
        -d "{
            \"name\": \"$REPO_NAME\",
            \"description\": \"星炽工作台 - 基于cc-haha的定制版本\",
            \"private\": false,
            \"auto_init\": false
        }" > /dev/null
    echo "✅ 仓库创建成功"
else
    echo "❌ 检查仓库失败 (HTTP $HTTP_CODE)"
    exit 1
fi

# 5. 推送代码
echo ""
echo "步骤5：推送代码到GitHub..."
git push -u origin main

echo ""
echo "=== 推送完成 ==="
echo "✅ 代码已成功推送到: https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo ""
echo "后续操作："
echo "1. 查看仓库: https://github.com/${GITHUB_USER}/${REPO_NAME}"
echo "2. 跟随上游更新:"
echo "   cd $PROJECT_DIR"
echo "   git fetch upstream"
echo "   git merge upstream/main"
echo "   git push origin main"