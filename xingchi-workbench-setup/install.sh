#!/bin/bash
set -e

# 星炽工作台完整安装脚本
# 功能：下载、重命名、设置Git仓库

WORK_DIR="/Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOWNLOAD_URL="https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip"
PROXY="http://127.0.0.1:54840"

echo "=== 星炽工作台安装脚本 ==="
echo "工作目录: $WORK_DIR"
echo ""

# 创建工作目录
mkdir -p "$WORK_DIR"
cd "$WORK_DIR"

# 步骤1：下载zip文件
echo "步骤1：下载cc-haha项目..."
if [ -f "cc-haha.zip" ]; then
    echo "检测到已存在的zip文件，跳过下载"
else
    echo "开始下载（使用本地代理）..."
    curl -x "$PROXY" -L -o cc-haha.zip "$DOWNLOAD_URL" \
        --connect-timeout 60 \
        --max-time 21600 \
        --retry 5 \
        --retry-delay 10 \
        --progress-bar
    
    # 检查下载是否成功
    if [ ! -f "cc-haha.zip" ] || [ $(stat -f%z cc-haha.zip 2>/dev/null || stat -c%s cc-haha.zip 2>/dev/null) -lt 10000000 ]; then
        echo "警告：下载可能不完整，尝试继续..."
    fi
fi

# 步骤2：解压zip文件
echo ""
echo "步骤2：解压项目..."
if [ -d "cc-haha-main" ]; then
    echo "检测到已解压的目录，跳过解压"
else
    unzip -q cc-haha.zip
    echo "解压完成"
fi

# 步骤3：重命名项目
echo ""
echo "步骤3：重命名项目为星炽工作台..."
cd cc-haha-main
bash "$SCRIPT_DIR/rename-xingchi.sh"

# 步骤4：设置Git仓库
echo ""
echo "步骤4：设置Git仓库..."
# 初始化Git（如果尚未初始化）
if [ ! -d ".git" ]; then
    git init
    echo "Git仓库已初始化"
fi

# 添加原始GitHub仓库作为upstream
if ! git remote get-url upstream >/dev/null 2>&1; then
    git remote add upstream https://github.com/NanmiCoder/cc-haha.git
    echo "已添加upstream远程仓库: https://github.com/NanmiCoder/cc-haha.git"
else
    echo "upstream远程仓库已存在"
fi

# 创建dev分支用于自定义修改
if ! git branch --list dev >/dev/null 2>&1; then
    git checkout -b dev
    echo "已创建并切换到dev分支"
else
    git checkout dev
    echo "已切换到dev分支"
fi

# 添加所有文件并创建初始提交
git add .
git commit -m "初始化星炽工作台：基于cc-haha v0.6.4重命名" || echo "没有需要提交的更改"

echo ""
echo "=== 安装完成 ==="
echo ""
echo "项目已设置在: $WORK_DIR/cc-haha-main"
echo "可执行文件: ./bin/xingchi-workbench"
echo ""
echo "Git仓库信息："
echo "  upstream: https://github.com/NanmiCoder/cc-haha.git"
echo "  当前分支: dev"
echo ""
echo "使用方法："
echo "  1. 安装依赖: npm install 或 yarn"
echo "  2. 运行: ./bin/xingchi-workbench"
echo ""
echo "更新上游代码："
echo "  1. git fetch upstream"
echo "  2. git merge upstream/main"
echo "  3. 解决可能的冲突"
echo ""
echo "备份文件保存在: $WORK_DIR/cc-haha-main/backup/"