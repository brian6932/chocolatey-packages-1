﻿$ErrorActionPreference = 'Stop'
$toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)
. "$toolsPath\helpers.ps1"

$pp = Get-PackageParameters

$parameters += if ($pp.NoDesktopShortcut)     { " /desktopshortcut 0"; Write-Host "Desktop shortcut won't be created" }
$parameters += if ($pp.NoTaskbarShortcut)     { " /pintotaskbar 0"; Write-Host "Opera won't be pinned to taskbar" }

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  fileType       = 'exe'
  url            = 'https://get.geo.opera.com/pub/opera-developer/64.0.3394.0/win/Opera_Developer_64.0.3394.0_Setup.exe'
  url64          = 'https://get.geo.opera.com/pub/opera-developer/64.0.3394.0/win/Opera_Developer_64.0.3394.0_Setup_x64.exe'
  checksum       = 'ac4e2faa6506cf1ccae857dcbc9d4ee79666e9c6149958320be5ce873ac48fec'
  checksum64     = '5002def4a9b558f851d002f57a80b169ff0029c16f2bc303407fc23f2579c3dc'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  silentArgs     = '/install /silent /launchopera 0 /setdefaultbrowser 0' + $parameters
  validExitCodes = @(0)
}

$version = '64.0.3394.0'
if (!$Env:ChocolateyForce -and (IsVersionAlreadyInstalled $version)) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage @packageArgs
}
