# 星炽工作台安装指南

## 当前状态

由于网络环境限制（GitHub访问不稳定），自动下载多次失败。已准备好所有自动化脚本，待网络恢复后可一键完成。

## 已创建的脚本

1. **下载脚本**：`download-cc-haha.sh`
   - 尝试多个GitHub镜像源
   - 支持断点续传
   - 自动检测下载完整性

2. **重命名脚本**：`rename-xingchi.sh`
   - 将cc-haha重命名为"星炽工作台"
   - 修改package.json、README、可执行文件
   - 修复macOS兼容性问题

3. **完整安装脚本**：`install.sh`
   - 自动化完整流程：下载→解压→重命名→Git设置
   - 设置upstream远程仓库
   - 创建dev分支

## 手动安装步骤

### 方法一：手动下载（推荐）

1. **下载项目**：
   - 访问：https://github.com/NanmiCoder/cc-haha
   - 点击绿色 "Code" 按钮 → "Download ZIP"
   - 保存为：`/Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench/cc-haha.zip`

2. **运行安装脚本**：
   ```bash
   cd /Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench-setup
   bash install.sh
   ```

### 方法二：使用代理下载

如果本地代理(127.0.0.1:54840)可用：
```bash
cd /Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench-setup
bash download-cc-haha.sh
```

## 安装后操作

1. **安装依赖**：
   ```bash
   cd /Users/liushuang/WorkBuddy/2026-09-17-13-27-16/xingchi-workbench/cc-haha-main
   npm install  # 或 yarn
   ```

2. **测试运行**：
   ```bash
   ./bin/xingchi-workbench
   ```

3. **Git操作**：
   - 查看upstream：`git remote -v`
   - 更新上游：`git fetch upstream && git merge upstream/main`
   - 推送到自己的仓库：`git push origin dev`

## 项目结构

安装完成后：
```
xingchi-workbench/
├── cc-haha.zip          # 下载的zip文件
├── cc-haha-main/        # 解压后的项目目录
│   ├── bin/
│   │   └── xingchi-workbench  # 重命名后的可执行文件
│   ├── package.json     # 名称已改为xingchi-workbench
│   ├── README.md        # 标题已改为"星炽工作台"
│   └── ...其他文件
└── backup/              # 原始文件备份
```

## 故障排除

### 下载失败
- 检查网络连接
- 尝试使用VPN或代理
- 手动下载zip文件

### 重命名脚本错误
- 确保在cc-haha根目录运行
- 检查文件权限：`chmod +x bin/xingchi-workbench`

### Git问题
- 重新添加upstream：`git remote add upstream https://github.com/NanmiCoder/cc-haha.git`
- 检查分支：`git branch -a`

## 未来扩展

### 颜色主题定制
- 主题文件位于桌面端代码中
- 可修改CSS/JavaScript/TypeScript文件
- 建议在dev分支上进行修改

### 实时视频/麦克风接入
- 推荐通过插件系统实现
- 开发MCP服务器处理音视频
- 保持核心代码最小修改