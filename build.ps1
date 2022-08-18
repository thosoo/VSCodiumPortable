Start-Process "PortableApps.comLauncherGenerator.exe" -ArgumentList ".\VSCodiumPortable\" -Wait
Start-Process "PortableApps.comInstaller.exe" -ArgumentList ".\VSCodiumPortable\" -Wait
dir | echo
