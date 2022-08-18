Start-Process ".\PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe" -ArgumentList ".\VSCodiumPortable\" -Wait
Start-Process ".\PortableApps.comInstaller\PortableApps.comInstaller.exe" -ArgumentList ".\VSCodiumPortable\" -Wait
dir | echo
