#!/bin/bash
set -e

# 星炽工作台重命名脚本
# 将cc-haha项目重命名为星炽工作台

echo "开始将cc-haha重命名为星炽工作台..."

# 检查是否在正确的目录
if [ ! -f "package.json" ]; then
    echo "错误：未找到package.json，请在cc-haha根目录运行此脚本"
    exit 1
fi

# 创建备份目录
mkdir -p backup
cp package.json backup/package.json
cp README.md backup/README.md 2>/dev/null || true

# 1. 修改package.json
echo "修改package.json..."
# 使用临时文件避免sed -i问题
temp_file=$(mktemp)
sed 's/"claude-code-local"/"xingchi-workbench"/g' package.json > "$temp_file"
mv "$temp_file" package.json

# 2. 修改README.md标题
echo "修改README.md..."
if [ -f "README.md" ]; then
    temp_file=$(mktemp)
    sed 's/# Claude Code Haha/# 星炽工作台/g' README.md > "$temp_file"
    mv "$temp_file" README.md
fi

# 3. 重命名可执行文件
echo "重命名可执行文件..."
if [ -f "bin/claude-haha" ]; then
    mv bin/claude-haha bin/xingchi-workbench
    chmod +x bin/xingchi-workbench
fi

# 4. 修改源代码中的引用（如果存在）
echo "修改源代码引用..."
if [ -d "src" ]; then
    find src -type f -name "*.ts" -o -name "*.js" -o -name "*.tsx" -o -name "*.jsx" | while read file; do
        if grep -q "claude-haha" "$file" 2>/dev/null; then
            temp_file=$(mktemp)
            sed 's/claude-haha/xingchi-workbench/g' "$file" > "$temp_file"
            mv "$temp_file" "$file"
        fi
    done
fi

# 5. 修改配置文件中的引用
echo "修改配置文件..."
for config_file in *.json *.yaml *.yml *.toml; do
    if [ -f "$config_file" ] && [ "$config_file" != "package.json" ]; then
        if grep -q "claude-haha\|Claude Code Haha" "$config_file" 2>/dev/null; then
            temp_file=$(mktemp)
            sed 's/claude-haha/xingchi-workbench/g; s/Claude Code Haha/星炽工作台/g' "$config_file" > "$temp_file"
            mv "$temp_file" "$config_file"
        fi
    fi
done

echo "重命名完成！"
echo "可执行文件已改为: bin/xingchi-workbench"
echo "项目名称已改为: xingchi-workbench (package.json)"
echo "README标题已改为: 星炽工作台"