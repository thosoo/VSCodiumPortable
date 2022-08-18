try {
  Import-Module PsIni
} catch {
  Install-Module -Scope CurrentUser PsIni
  Import-Module PsIni
}
$repoName = "VSCodium/vscodium"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$tag = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).tag_name
echo "UPSTREAM_TAG="+$tag | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append

$appinfo = Get-IniContent ".\VSCodiumPortable\App\AppInfo\appinfo.ini"
if ($appinfo["Version"]["DisplayVersion"] -ne $tag)
{
  $appinfo["Version"]["PackageVersion"]=-join($tag,".0")
  $appinfo["Version"]["DisplayVersion"]=$tag
  $appinfo | Out-IniFile -Force -Encoding ASCII -Pretty -FilePath ".\VSCodiumPortable\App\AppInfo\appinfo.ini"

  $installer = Get-IniContent ".\VSCodiumPortable\App\AppInfo\installer.ini"
  $installer["DownloadFiles"]["DownloadURL"]=-join("https://github.com/VSCodium/vscodium/releases/download/",$tag,"/VSCodium-win32-ia32-",$tag,".zip")
  $installer["DownloadFiles"]["DownloadFilename"]=-join("VSCodium-win32-ia32-",$tag,".zip")
  $installer["DownloadFiles"]["Download2URL"]=-join("https://github.com/VSCodium/vscodium/releases/download/",$tag,"/VSCodium-win32-x64-",$tag,".zip")
  $installer["DownloadFiles"]["Download2Filename"]=-join("VSCodium-win32-x64-",$tag,".zip")
  $installer | Out-IniFile -Force -Encoding ASCII -Pretty -FilePath ".\VSCodiumPortable\App\AppInfo\installer.ini"
  Write-Host "Bumped to "+$tag
  echo "SHOULD_COMMIT=yes" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
}
else{
  Write-Host "No changes."
  echo "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
}
