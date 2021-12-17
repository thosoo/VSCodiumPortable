try {
  Import-Module PsIni
} catch {
  Install-Module -Scope CurrentUser PsIni
  Import-Module PsIni
}
$repoName = "VSCodium/vscodium"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$tag = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).tag_name
$appinfo = Get-IniContent ".\VSCodiumPortable\App\AppInfo\appinfo.ini"
$appinfo["Version"]["PackageVersion"]=$tag
$appinfo["Version"]["DisplayVersion"]=$tag
$appinfo | Out-IniFile -Force -FilePath ".\VSCodiumPortable\App\AppInfo\appinfo.ini"

$installer = Get-IniContent ".\VSCodiumPortable\App\AppInfo\installer.ini"
$installer["DownloadFiles"]["DownloadURL"]=-join("https://github.com/VSCodium/vscodium/releases/download/",$tag,"/VSCodium-win32-ia32-",$tag,".zip")
$installer["DownloadFiles"]["DownloadFilename"]=-join("VSCodium-win32-ia32-",$tag,".zip")
$installer["DownloadFiles"]["Download2URL"]=-join("https://github.com/VSCodium/vscodium/releases/download/",$tag,"/VSCodium-win32-x64-",$tag,".zip")
$installer["DownloadFiles"]["Download2Filename"]=-join("VSCodium-win32-x64-",$tag,".zip")
$installer | Out-IniFile -Force -FilePath ".\VSCodiumPortable\App\AppInfo\installer.ini"