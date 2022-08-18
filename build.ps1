dir
Write-Host "Starting Launcher Generator"
Start-Process "D:\a\VSCodiumPortable\VSCodiumPortable\PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe" -ArgumentList "D:\a\VSCodiumPortable\VSCodiumPortable\VSCodiumPortable\" -Wait
Write-Host "Starting Installer Generator"
Start-Process "D:\a\VSCodiumPortable\VSCodiumPortable\PortableApps.comInstaller\PortableApps.comInstaller.exe" -ArgumentList "D:\a\VSCodiumPortable\VSCodiumPortable\VSCodiumPortable\" -Wait
dir
