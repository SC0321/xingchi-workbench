#!/bin/bash
# 下载cc-haha项目的脚本，尝试多个镜像源

set -e

DOWNLOAD_DIR="/Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench"
PROXY="http://127.0.0.1:54840"
FILENAME="cc-haha.zip"

# 镜像列表（按优先级排序）
MIRRORS=(
    "https://ghproxy.net/https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip"
    "https://mirror.ghproxy.com/https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip"
    "https://gh-proxy.com/https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip"
    "https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip"
)

# 创建下载目录
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

echo "=== 下载cc-haha项目 ==="
echo "下载目录: $DOWNLOAD_DIR"
echo ""

# 尝试每个镜像
for url in "${MIRRORS[@]}"; do
    echo "尝试镜像: $url"
    
    # 使用代理下载
    if curl -x "$PROXY" -L -C - -o "$FILENAME" "$url" \
        --connect-timeout 30 \
        --max-time 3600 \
        --retry 3 \
        --retry-delay 5 \
        --progress-bar; then
        
        # 检查文件大小
        if [ -f "$FILENAME" ]; then
            filesize=$(stat -f%z "$FILENAME" 2>/dev/null || stat -c%s "$FILENAME" 2>/dev/null || echo 0)
            if [ "$filesize" -gt 10000000 ]; then
                echo ""
                echo "✅ 下载成功！文件大小: $filesize 字节"
                echo "文件位置: $DOWNLOAD_DIR/$FILENAME"
                exit 0
            else
                echo "❌ 文件太小 ($filesize 字节)，可能不完整"
                rm -f "$FILENAME"
            fi
        fi
    else
        echo "❌ 下载失败"
    fi
    echo ""
done

echo "❌ 所有镜像都失败了"
echo ""
echo "手动下载方法："
echo "1. 访问: https://github.com/NanmiCoder/cc-haha"
echo "2. 点击绿色 'Code' 按钮 → 'Download ZIP'"
echo "3. 将下载的文件保存为: $DOWNLOAD_DIR/$FILENAME"
echo "4. 重新运行此脚本"