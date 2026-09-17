---
markmap:
  colorFreezeLevel: 2
  initialExpandLevel: 2
  maxWidth: 380
---

# Claude Code Haha (cc-haha)
- 基于泄露源码的增强版 AI 编码平台
- 本地优先的跨平台桌面工作空间
- 14.3k Stars / 8.5k Forks

## 项目背景
- 基于 2026年3月31日 Anthropic npm registry 泄露的 Claude Code 源码
- 经过系统性修复和功能增强后的本地可运行版本
- 许可证: MIT（仅供学习和研究用途，原始版权归 Anthropic 所有）

## 技术栈
- 语言: TypeScript
- 运行时: Bun
- 桌面 UI: React + Vite
- 终端 UI: React + Ink
- 桌面 APP: Electron / Tauri 2
- API: Anthropic SDK
- 协议: MCP, LSP

## 核心功能
### 完整 TUI 与无头模式
- 保留与官方 Claude Code 一致的 Ink TUI 交互界面
- 支持 --print 无头模式用于脚本自动化和 CI/CD 场景

### 多提供商 API 支持
- 支持接入任意 Anthropic 兼容 API
- 包括 MiniMax、OpenRouter、DeepSeek、OpenAI、Ollama 等
- 有效降低供应商锁定风险和运营成本

### 桌面端与 Computer Use
- 基于 Tauri 2 + React 构建图形化桌面客户端
- 集成会话管理、多项目切换、代码 Diff、权限确认、提供商配置、定时任务和 IM 适配器
- 支持 macOS/Windows 平台的截屏、鼠标和键盘控制

### IM 远程接入
- 支持通过 Telegram、飞书、微信、钉钉四大平台远程驱动
- 用户可在移动端完成对话、项目切换和权限审批
- 实现随时随地的远程操控

### 多 Agent 系统
- 支持多 Agent 协作工作台
- 可视化多 Agent 协作团队
- 成员、任务、通信流和依赖泳道一目了然

### 动态工作流编排
- 模型当场编写并运行编排脚本
- 并发或流水线调度多个子代理
- 支持阶段视图、中断与断点续跑

### 模型请求追踪
- 本地记录每轮模型请求的状态与耗时
- 可搜索筛选，快速定位卡死或失败调用

### 其他功能
- 多会话工作台：标签页、项目切换、终端入口和会话历史集中管理
- 全局搜索：按 Cmd+K 跨所有会话全文搜索
- 分支/Worktree 启动：新会话可以选择仓库分支
- 改动逐个文件审阅：右侧工作区列出本轮改动，点开就是带语法高亮的 Diff
- 内置浏览器预览：Agent 刚改完的页面直接在应用内渲染
- 五档权限模式：从「询问权限」到「跳过权限」，危险命令、工具调用和 AI 反问都在桌面端审批
- 图片生成：聊天中直接生成和编辑图片
- MCP 图形化管理：界面化增删改 MCP Server
- 六套配色主题：纯白、纸墨、经典暖色、青瓷、墨夜、墨夜蓝
- 技能市场：发现、预览、安装第三方技能
- 桌面宠物：搭搭、弧弧、补补、回回随任务状态换动作
- H5 远程访问：扫码用手机浏览器接入当前会话
- IM 接入：通过 Telegram / 飞书 / 微信 / 钉钉 / WhatsApp / 企业微信 / QQ / Slack 远程对话
- 定时任务与用量统计：创建计划任务在独立会话执行

## 使用场景
- 本地 AI 编码助手
- 跨平台桌面工作空间
- 多 Agent 协作开发
- 远程操控与团队协作
- Computer Use 自动化任务

## 项目特点
- 本地优先：数据和执行都在本地
- 跨平台：支持 macOS、Windows、Linux
- 多模型：支持多种 AI 模型提供商
- 可扩展：通过技能市场和 MCP 扩展功能
- 开源：MIT 许可证，社区驱动
