# 星炽工作台

<p align="center">
  <img src="docs/images/readme-cover-zh.jpg" alt="cc-haha — Claude Code 开源桌面端" width="960">
</p>

<div align="center">

[![GitHub Stars](https://img.shields.io/github/stars/NanmiCoder/cc-haha?style=social)](https://github.com/NanmiCoder/cc-haha/stargazers)
[![License](https://img.shields.io/badge/License-MIT-blue)](https://github.com/NanmiCoder/cc-haha/blob/main/LICENSE)

</div>

星炽工作台是一个**桌面端 Claude Code 工作台**：多会话与全局搜索、分支 / Worktree 启动、Diff 审阅、内置浏览器预览、图形化权限审批、模型自选（Claude / ChatGPT / Grok / 预设 / 本地端点）、图片生成、MCP 与 SubAgent 可视化管理、Agent Teams 协作工作台、动态 Workflow 编排、模型请求追踪、Computer Use、技能市场、多主题、桌面宠物、H5 远程访问、IM 接入和定时任务，集中在一个 macOS / Windows / Linux APP 里。

## 桌面端亮点

- **多会话工作台**：标签页、项目切换、终端入口和会话历史集中管理，侧边栏宽度可拖拽。
- **全局搜索**：按 Cmd+K 跨所有会话全文搜索，一键跳到命中位置。
- **分支 / Worktree 启动**：新会话可以选择仓库分支，并决定用当前工作树还是隔离 Worktree。
- **改动逐个文件审阅**：右侧工作区列出本轮改动，点开就是带语法高亮的 Diff，整轮可撤销。
- **内置浏览器预览**：Agent 刚改完的页面直接在应用内渲染，登录态和 Cookie 真实可用。

## 安装桌面端

1. 前往 [Releases](https://github.com/NanmiCoder/cc-haha/releases) 下载 macOS / Windows / Linux 桌面端安装包。
2. 首次启动后，在桌面端设置里配置模型提供商、API Key 和默认模型。

## 从源码启动 CLI

```bash
bun install
cp .env.example .env
./bin/xingchi-workbench
```

## 技术栈

| 类别 | 技术 |
|------|------|
| 语言 | TypeScript |
| 桌面 APP | Electron |
| 桌面 UI | React + Vite |
| 本地运行时 | Bun |
| 终端 UI | React + Ink |
| CLI 解析 | Commander.js |
| API | Anthropic SDK |
| 协议 | MCP, LSP |

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件