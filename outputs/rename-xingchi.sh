#!/bin/bash
# rename-xingchi.sh
# 将cc-haha项目重命名为“星炽工作台”
# 使用方法：将此脚本放在cc-haha根目录，运行 bash rename-xingchi.sh

set -e  # 遇到错误立即退出

echo "开始将cc-haha重命名为星炽工作台..."

# 检查是否在cc-haha目录
if [ ! -f "package.json" ]; then
    echo "错误：未找到package.json，请在cc-haha根目录运行此脚本"
    exit 1
fi

# 备份原始文件
echo "备份原始文件..."
mkdir -p backup
cp package.json backup/package.json
cp README.md backup/README.md 2>/dev/null || true
cp README.en.md backup/README.en.md 2>/dev/null || true

# 修改package.json
echo "修改package.json..."
sed -i '' 's/"claude-code-local"/"xingchi-workbench"/g' package.json
sed -i '' 's/"name": "claude-code-local"/"name": "xingchi-workbench"/g' package.json

# 修改README.md（中文）
echo "修改README.md..."
if [ -f "README.md" ]; then
    # 替换标题
    sed -i '' 's/# Claude Code Haha/# 星炽工作台/g' README.md
    sed -i '' 's/## Claude Code Haha/## 星炽工作台/g' README.md
    
    # 替换描述
    sed -i '' 's/Claude Code Haha 是一个/星炽工作台是一个/g' README.md
    sed -i '' 's/Claude Code Haha/星炽工作台/g' README.md
    
    # 替换项目名称
    sed -i '' 's/cc-haha/星炽工作台/g' README.md
    sed -i '' 's/claude-haha/xingchi-workbench/g' README.md
    
    # 替换GitHub链接中的名称（可选，保留原始链接）
    # sed -i '' 's/NanmiCoder\/cc-haha/你的用户名\/xingchi-workbench/g' README.md
fi

# 修改README.en.md（英文）
echo "修改README.en.md..."
if [ -f "README.en.md" ]; then
    sed -i '' 's/# Claude Code Haha/# Xingchi Workbench/g' README.en.md
    sed -i '' 's/## Claude Code Haha/## Xingchi Workbench/g' README.en.md
    sed -i '' 's/Claude Code Haha/Xingchi Workbench/g' README.en.md
    sed -i '' 's/cc-haha/xingchi-workbench/g' README.en.md
    sed -i '' 's/claude-haha/xingchi-workbench/g' README.en.md
fi

# 修改可执行文件名
echo "修改可执行文件名..."
if [ -f "bin/claude-haha" ]; then
    mv bin/claude-haha bin/xingchi-workbench
    chmod +x bin/xingchi-workbench
fi

# 修改package.json中的bin字段
echo "修改package.json中的bin字段..."
sed -i '' 's/"claude-haha": ".\/bin\/claude-haha"/"xingchi-workbench": ".\/bin\/xingchi-workbench"/g' package.json

# 修改文档中的引用
echo "修改文档中的引用..."
find . -name "*.md" -not -path "./backup/*" -not -path "./node_modules/*" -exec sed -i '' 's/Claude Code Haha/星炽工作台/g' {} +
find . -name "*.md" -not -path "./backup/*" -not -path "./node_modules/*" -exec sed -i '' 's/cc-haha/星炽工作台/g' {} +
find . -name "*.md" -not -path "./backup/*" -not -path "./node_modules/*" -exec sed -i '' 's/claude-haha/xingchi-workbench/g' {} +

# 修改源代码中的引用（谨慎操作）
echo "修改源代码中的引用..."
find . -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" | grep -v node_modules | grep -v backup | xargs sed -i '' 's/Claude Code Haha/星炽工作台/g' 2>/dev/null || true
find . -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" | grep -v node_modules | grep -v backup | xargs sed -i '' 's/cc-haha/星炽工作台/g' 2>/dev/null || true
find . -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.jsx" | grep -v node_modules | grep -v backup | xargs sed -i '' 's/claude-haha/xingchi-workbench/g' 2>/dev/null || true

# 修改配置文件
echo "修改配置文件..."
if [ -f ".env.example" ]; then
    sed -i '' 's/CLAUDE_CODE/XINGCHI_WORKBENCH/g' .env.example
fi

# 创建新的README.md头部
echo "创建新的README.md头部..."
if [ -f "README.md" ]; then
    # 备份原始头部
    head -20 README.md > backup/readme-header.md
    
    # 替换整个头部（可选，这里只替换关键部分）
    # 如果需要完全重写头部，可以取消注释以下代码
    # cat > new-header.md << 'EOF'
    # # 星炽工作台
    # 
    # 基于Claude Code的本地优先跨平台桌面工作空间
    # 
    # [![GitHub Stars](https://img.shields.io/github/stars/NanmiCoder/cc-haha?style=social)](https://github.com/NanmiCoder/cc-haha/stargazers)
    # [![License](https://img.shields.io/badge/License-MIT-blue)](https://github.com/NanmiCoder/cc-haha/blob/main/LICENSE)
    # 
    # **English** | [简体中文](README.md)
    # 
    # 星炽工作台是一个桌面端Claude Code工作台：多会话与全局搜索、分支/Worktree启动、Diff审阅、内置浏览器预览、图形化权限审批、模型自选...
    # EOF
    # 
    # # 替换头部
    # sed -i '' '1,20d' README.md
    # cat new-header.md > temp.md
    # tail -n +21 README.md >> temp.md
    # mv temp.md README.md
    # rm new-header.md
fi

# 清理临时文件
echo "清理临时文件..."
rm -f cc-haha.tar.gz

# 完成
echo "重命名完成！"
echo "请检查修改后的文件，确保所有引用都已正确更新。"
echo "原始文件备份在 backup/ 目录中。"
echo ""
echo "下一步："
echo "1. 安装依赖：bun install"
echo "2. 启动项目：./bin/xingchi-workbench"
echo "3. 测试功能是否正常"