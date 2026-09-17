#!/usr/bin/env python3
"""
下载cc-haha项目的Python脚本
使用urllib，避免依赖外部库
"""

import os
import sys
import urllib.request
import urllib.error
import ssl
import time

# 配置
DOWNLOAD_DIR = "/Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench"
FILENAME = "cc-haha.zip"
PROXY = "http://127.0.0.1:54840"

# 镜像列表
MIRRORS = [
    "https://ghproxy.net/https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip",
    "https://mirror.ghproxy.com/https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip",
    "https://gh-proxy.com/https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip",
    "https://github.com/NanmiCoder/cc-haha/archive/refs/heads/main.zip",
]

def download_with_proxy(url, output_path, proxy=None):
    """使用代理下载文件"""
    try:
        # 创建代理处理器
        if proxy:
            proxy_handler = urllib.request.ProxyHandler({
                'http': proxy,
                'https': proxy
            })
            opener = urllib.request.build_opener(proxy_handler)
        else:
            opener = urllib.request.build_opener()
        
        # 设置超时
        opener.addheaders = [
            ('User-Agent', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36'),
        ]
        
        print(f"  下载中: {url}")
        response = opener.open(url, timeout=60)
        
        # 获取文件大小
        content_length = response.headers.get('Content-Length')
        total_size = int(content_length) if content_length else None
        
        # 下载文件
        downloaded = 0
        block_size = 8192
        
        with open(output_path, 'wb') as f:
            while True:
                data = response.read(block_size)
                if not data:
                    break
                f.write(data)
                downloaded += len(data)
                
                # 显示进度
                if total_size:
                    percent = (downloaded / total_size) * 100
                    print(f"\r  进度: {percent:.1f}% ({downloaded}/{total_size})", end='', flush=True)
                else:
                    print(f"\r  已下载: {downloaded} 字节", end='', flush=True)
        
        print()  # 换行
        return True
        
    except Exception as e:
        print(f"  下载失败: {e}")
        return False

def main():
    print("=== 下载cc-haha项目 ===")
    print(f"下载目录: {DOWNLOAD_DIR}")
    print()
    
    # 创建下载目录
    os.makedirs(DOWNLOAD_DIR, exist_ok=True)
    output_path = os.path.join(DOWNLOAD_DIR, FILENAME)
    
    # 尝试每个镜像
    for url in MIRRORS:
        print(f"尝试镜像: {url}")
        
        # 使用代理下载
        if download_with_proxy(url, output_path, PROXY):
            # 检查文件大小
            if os.path.exists(output_path):
                filesize = os.path.getsize(output_path)
                if filesize > 10000000:  # 大于10MB
                    print(f"✅ 下载成功！文件大小: {filesize:,} 字节")
                    print(f"文件位置: {output_path}")
                    return 0
                else:
                    print(f"❌ 文件太小 ({filesize:,} 字节)，可能不完整")
                    os.remove(output_path)
        print()
    
    print("❌ 所有镜像都失败了")
    print()
    print("手动下载方法：")
    print("1. 访问: https://github.com/NanmiCoder/cc-haha")
    print("2. 点击绿色 'Code' 按钮 → 'Download ZIP'")
    print(f"3. 将下载的文件保存为: {output_path}")
    print("4. 重新运行此脚本")
    return 1

if __name__ == "__main__":
    sys.exit(main())