Get-ChildItem

Write-Host "Starting Launcher Generator"
$launcherPath = "D:\a\VSCodiumPortable\VSCodiumPortable\PortableApps.comLauncher\PortableApps.comLauncherGenerator.exe"
$launcherArgs = "D:\a\VSCodiumPortable\VSCodiumPortable\VSCodiumPortable"
Start-Process -FilePath $launcherPath -ArgumentList $launcherArgs -NoNewWindow -Wait

Write-Host "Starting Installer Generator"
$installerPath = "D:\a\VSCodiumPortable\VSCodiumPortable\PortableApps.comInstaller\PortableApps.comInstaller.exe"
$installerArgs = "D:\a\VSCodiumPortable\VSCodiumPortable\VSCodiumPortable"
Start-Process -FilePath $installerPath -ArgumentList $installerArgs -NoNewWindow -Wait

Get-ChildItem
