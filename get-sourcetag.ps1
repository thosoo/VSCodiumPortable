$repoName = "VSCodium/vscodium"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$tag = (Invoke-WebRequest $releasesUri | ConvertFrom-Json).tag_name
echo $tag
