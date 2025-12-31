Remove-Item -Force -EA 0 ".git/index.lock",".git/HEAD.lock"
git config --global user.name "Michaelunkai"
git config --global user.email "Michaelunkai@users.noreply.github.com"
git config --global init.defaultBranch main
git config --global core.autocrlf false
git config --global --add safe.directory (Get-Location).Path
$r=(Split-Path -Leaf (Get-Location)) -replace " ","-" -replace "[^a-zA-Z0-9-]",""
$r=$r.ToLower()
$u="Michaelunkai"
if(!(Test-Path ".git")){git init -b main; git config core.filemode false; git config --add safe.directory (Get-Location).Path}
git add -A
$c=git status --porcelain
if($c){git commit -m "Auto commit $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"} elseif(!(git log -1 2>$null)){git commit --allow-empty -m "Initial commit"}
git remote remove origin 2>$null
git remote add origin "https://github.com/$u/$r.git"
git branch -M main
git push -u origin main --force 2>$null
if($LASTEXITCODE -ne 0){gh repo create "$u/$r" --public 2>$null; Start-Sleep 2; git push -u origin main --force}
Remove-Item -Force -EA 0 ".git/*.lock"
Write-Host "Done: https://github.com/$u/$r"
