# Import PsIni module, install it if not found
$module = Get-Module -Name PsIni -ErrorAction SilentlyContinue
if (!$module) {
    Install-Module -Scope CurrentUser PsIni
    Import-Module PsIni
} else {
    Import-Module PsIni
}

# Define repository name and API endpoint
$repoName = "VSCodium/vscodium"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
try { $tag = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).tag_name }
catch {
  Write-Host "Error while pulling API."
  echo "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
  break
}

echo "UPSTREAM_TAG=$tag" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append

$appinfoFilePath = ".\VSCodiumPortable\App\AppInfo\appinfo.ini"
if ((Test-Path $appinfoFilePath) -and (Get-IniContent $appinfoFilePath).Version.DisplayVersion -ne $tag) {
    $appinfo = @{
        Version = @{
            DisplayVersion = $tag
            PackageVersion = "$tag.0"
        }
    }
    Out-IniFile -InputObject $appinfo -Force -Encoding ASCII -Pretty -FilePath $appinfoFilePath

    $installerFilePath = ".\VSCodiumPortable\App\AppInfo\installer.ini"
    if (Test-Path $installerFilePath) {
        $downloadURL = "https://github.com/VSCodium/vscodium/releases/download/$tag/VSCodium-win32-ia32-$tag.zip"
        $downloadFilename = "VSCodium-win32-ia32-$tag.zip"
        $download2URL = "https://github.com/VSCodium/vscodium/releases/download/$tag/VSCodium-win32-x64-$tag.zip"
        $download2Filename = "VSCodium-win32-x64-$tag.zip"
        $installer = @{
            DownloadFiles = @{
                DownloadURL = $downloadURL
                DownloadFilename = $downloadFilename
                Download2URL = $download2URL
                Download2Filename = $download2Filename
            }
        }
        Out-IniFile -InputObject $installer -Force -Encoding ASCII -Pretty -FilePath $installerFilePath
        Write-Host "Bumped to $tag"
        Write-Output "SHOULD_COMMIT=yes" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
    }
}
else {
    Write-Host "No changes."
    Write-Output "SHOULD_COMMIT=no" | Out-File -FilePath $Env:GITHUB_ENV -Encoding utf8 -Append
}
