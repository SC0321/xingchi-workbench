# 星炽工作台维护说明

## 启动

需要 Bun 1.3.14 和 Node.js。首次安装：

```bash
bun install
(cd adapters && bun install)
(cd desktop && bun install)
cd desktop
bun run electron:dev
```

Electron 固定为 42.11.4，仍使用 CommonJS 主进程。不要用 Node/Bun 直接执行 `electron-dist/main.cjs`：普通 Node 解析 `require('electron')` 返回可执行文件路径，不是 Electron API。启动器直接定位 Electron binary，清除 IDE 遗留的 `ELECTRON_RUN_AS_NODE`，不依赖 `path.txt`，因而不需要给 node_modules 打 `.trim()` 补丁。

`electron:dev` 会编译后端 sidecar、主进程和 preload，再启动 Vite 与 Electron。macOS 开发模式跳过需要稳定签名证书的 Computer Use helper；聊天工作台可以运行，Computer Use 需要配置稳定签名身份并执行完整 `bun run build:sidecars`。正式打包仍执行原有签名要求。不要绕过下载校验。

本地服务的 OPTIONS 预检只对回环连接、本地/打包来源和声明 Authorization 的请求放行，实际业务请求仍验证令牌。

## 合并上游

本 fork 最初由 ZIP 快照导入，历史与上游不相连，且项目位于多层子目录。本次已保留原提交、把应用移到仓库根目录，并用与导入快照一致的 v0.6.4 建立共同祖先。已合并 upstream/main 的 f2bfaab50f3be908f548245a74fdaa3ca2c71a95（v0.6.4 后 README 语言布局更新）。以后不需要重复 `--allow-unrelated-histories` 或 `-s ours`。

保持 remote：

```bash
git remote -v
# upstream git@github.com:NanmiCoder/cc-haha.git
git fetch upstream
git merge upstream/main --no-edit
```

每次同步前工作树应干净。优先自动合并；冲突时保留上游功能更新，以及 package.json 的 name/bin/scripts、桌面 package 的 productName/appId/artifactName、Tauri 名称、菜单/托盘/通知名称和 CLI 路径的中文定制。同步修改相关测试期望值。

```bash
bun run scripts/check-xingchi-branding.ts
bun install
(cd adapters && bun install)
(cd desktop && bun install && bun run build:electron && bun run electron:dev)
# 退出应用后执行相关检查
bun run check:impact
bun run check:electron
bun run check:desktop
rg -n 'cc-haha|Claude Code Haha|claude-haha' desktop src package.json README*.md
```

搜索结果需要分类审阅：`cc-haha` 的存储目录、localStorage 键、协议/环境变量、原生 helper 签名标识、上游链接和作者署名保留兼容性，不能全局替换。用户可见的应用标题、菜单、托盘和通知应显示「星炽工作台」。macOS 上游设计默认不显示托盘，Windows/Linux 托盘通过回归测试检查。

合并提交信息统一为 `合并上游 vX.X.X 并维护中文重命名`。若希望提交前验证，可使用 `git merge upstream/main --no-commit --no-ff`，验证后 `git commit -m '合并上游 vX.X.X 并维护中文重命名'`。不要从 upstream 下载器自动覆盖本 fork 的发行包；发布前应另行维护 fork 的更新源和签名配置。
