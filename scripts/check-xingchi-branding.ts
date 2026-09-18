import assert from 'node:assert/strict'
import { readFileSync, existsSync } from 'node:fs'
import path from 'node:path'

const root = path.resolve(import.meta.dirname, '..')
const read = (file: string) => readFileSync(path.join(root, file), 'utf8')
const pkg = JSON.parse(read('package.json'))
const desktop = JSON.parse(read('desktop/package.json'))
const tauri = JSON.parse(read('desktop/src-tauri/tauri.conf.json'))
assert.equal(pkg.name, 'xingchi-workbench')
assert.equal(pkg.bin['xingchi-workbench'], './bin/xingchi-workbench')
assert.ok(existsSync(path.join(root, pkg.bin['xingchi-workbench'])))
assert.equal(desktop.name, 'xingchi-workbench-desktop')
assert.equal(desktop.build.productName, '星炽工作台')
assert.equal(desktop.build.appId, 'com.xingchi-workbench.desktop')
assert.equal(tauri.productName, '星炽工作台')
assert.equal(tauri.identifier, desktop.build.appId)
assert.equal(tauri.app.windows[0].title, '星炽工作台')
const required: Record<string, string[]> = {
  'desktop/index.html': ['<title>星炽工作台</title>'],
  'desktop/electron/main.ts': ['app.setName(DESKTOP_APP_NAME)'],
  'desktop/electron/services/appIdentity.ts': ["DESKTOP_APP_NAME = '星炽工作台'", "'com.xingchi-workbench.desktop'"],
  'desktop/electron/services/tray.ts': ['显示星炽工作台', '退出星炽工作台'],
  'desktop/electron/services/menu.ts': ["app.name || '星炽工作台'"],
  'desktop/src/stores/chatStore.ts': ['星炽工作台已完成回复', '星炽工作台需要你的确认'],
  'src/server/services/conversationService.ts': ['bin/xingchi-workbench', 'xingchi-workbench /login'],
  'src/server/services/desktopCliLauncherService.ts': ["DESKTOP_CLI_NAME = 'xingchi-workbench'", '# >>> 星炽工作台 PATH >>>'],
  'desktop/sidecars/launcherRouting.ts': ["'xingchi-workbench'", "'xingchi-workbench.exe'"],
}
for (const [file, values] of Object.entries(required)) {
  const source = read(file)
  for (const value of values) assert.ok(source.includes(value), `${file}: missing ${value}`)
}
assert.equal((read('desktop/src/stores/chatStore.ts').match(/title: '星炽工作台/g) ?? []).length, 3)
console.log('星炽工作台品牌检查通过（配置、窗口、菜单、托盘、通知和 CLI）')
