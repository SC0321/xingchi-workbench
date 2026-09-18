# 星炽动力品牌资源

- `sflare-logo.png`：用户提供的 SFLARE 公司横版 logo，用于新建会话、关于页和 Token 用量默认形象。
- `../app-icon.png`：用户提供的 A.png 图标，平台尺寸在 `desktop/src-tauri/icons/`，打包与安装时沿用。
- 作者和官方媒体入口统一在 `desktop/src/lib/brand.ts`。
- 社交二维码来源：https://www.xingchidongli.com/zh-CN/ （2026-09-18 核验），点击打开官方二维码供扫码关注。未确认官方 Bilibili 账号，因此不展示原作者的个人账号。
- 合并上游时保留上述文件，并运行 `bun scripts/check-xingchi-branding.ts`。更新安装后沿用应用 ID 和名称，覆盖原应用。
