#!/usr/bin/env bun

import { cp, mkdir, readFile, rm } from 'node:fs/promises'
import { existsSync } from 'node:fs'
import path from 'node:path'
import { spawnSync } from 'node:child_process'

if (process.platform !== 'darwin') {
  throw new Error('install:macos is only available on macOS')
}

const desktopRoot = path.resolve(import.meta.dir, '..')
const packageJson = JSON.parse(await readFile(path.join(desktopRoot, 'package.json'), 'utf8')) as {
  build?: { productName?: string; appId?: string }
}
const productName = packageJson.build?.productName?.trim()
const appId = packageJson.build?.appId?.trim()
if (!productName || !appId) throw new Error('desktop/package.json must define build.productName and build.appId')

const sourceCandidates = [
  path.join(desktopRoot, 'build-artifacts', 'electron', 'mac-arm64', `${productName}.app`),
  path.join(desktopRoot, 'build-artifacts', 'macos-arm64', `${productName}.app`),
]
const source = sourceCandidates.find(candidate => {
  return existsSync(candidate)
})
if (!source) {
  throw new Error(`Built app not found. Run "bun run electron:package:dir" first. Expected ${sourceCandidates[0]}`)
}

const applicationsDir = '/Applications'
const destination = path.join(applicationsDir, `${productName}.app`)
await mkdir(applicationsDir, { recursive: true })
await rm(destination, { recursive: true, force: true })
await cp(source, destination, { recursive: true })

const lsregister = '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister'
const runtimeApp = path.join(desktopRoot, 'node_modules', 'electron', 'dist', 'Electron.app')
// The development runtime is needed by electron:dev, but should not appear as
// a second user-facing application in Launchpad after installing the product.
spawnSync(lsregister, ['-u', runtimeApp], { stdio: 'ignore' })
spawnSync(lsregister, ['-f', destination], { stdio: 'ignore' })
spawnSync('/usr/bin/killall', ['Dock'], { stdio: 'ignore' })
console.log(`Installed ${productName} (${appId}) at ${destination}`)
