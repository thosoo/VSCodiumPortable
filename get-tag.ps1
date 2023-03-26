$repoName = "thosoo/VSCodiumPortable"
$releasesUri = "https://api.github.com/repos/$repoName/releases/latest"
$tag = (Invoke-RestMethod -Uri $releasesUri).tag_name
echo $tag
