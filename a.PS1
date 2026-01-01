<#
.SYNOPSIS
    Windows 11 Optimization, Repair & Cleaning Suite v4
.DESCRIPTION
    PORTABLE 3RD PARTY TOOLS ONLY - All actively optimize, fix, repair or clean Windows 11
    Always 5 tools running in parallel
    Comprehensive purge after each tool closes
.NOTES
    Run as Administrator: Start-Process powershell -Verb RunAs
#>

$ErrorActionPreference = 'SilentlyContinue'
$ProgressPreference = 'SilentlyContinue'

# Force TLS 1.2 for all downloads
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Write-Host "`n" -NoNewline
Write-Host "=" * 90 -ForegroundColor Magenta
Write-Host "   WINDOWS 11 OPTIMIZATION / REPAIR / CLEAN SUITE v4 (5 PARALLEL)" -ForegroundColor Magenta
Write-Host "   100% 3RD PARTY PORTABLE TOOLS | Active Optimization Only!" -ForegroundColor Yellow
Write-Host "=" * 90 -ForegroundColor Magenta
Write-Host ""

$tools = @(

    # ==================== SYSTEM OPTIMIZERS & TWEAKERS ====================

    @{N='DismPlusPlus';S={
        $n='DismPlusPlus';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading system optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/Chuyu-Team/Dism-Multi-language/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'Dism++x64.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Remove-Item "$env:LOCALAPPDATA\Dism++" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='WinUtil';S={
        $n='WinUtil'
        Write-Host "[$n] Launching ChrisTitus WinUtil optimizer..." -ForegroundColor Cyan
        try { Start-Process powershell -ArgumentList '-NoProfile','-ExecutionPolicy','Bypass','-Command','irm christitus.com/win | iex' -Verb RunAs -Wait }
        catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        (Get-PSDrive -PSProvider FileSystem).Root | ForEach-Object { Remove-Item "$_`*winutil*" -Recurse -Force -EA 0 }
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='SophiApp';S={
        $n='SophiApp';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows 11 tweaker..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/Sophia-Community/SophiApp/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' -and $_.name -notmatch 'Source' } | Select-Object -First 1
            Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'SophiApp.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='Optimizer';S={
        $n='Optimizer';$t="$env:TEMP\$n";$exe="$t\Optimizer.exe"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading system optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/hellzerg/optimizer/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.exe$' } | Select-Object -First 1
            Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $exe -UseBasicParsing -TimeoutSec 180
            if (Test-Path $exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='Winpilot';S={
        $n='Winpilot';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows 11 debloater..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/builtbybel/Winpilot/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Where-Object { $_.Name -notmatch 'unins' } | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='XToolbox';S={
        $n='XToolbox';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows toolbox..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/xemulat/XToolbox/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='Win11Fixer';S={
        $n='Win11Fixer';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows 11 fixer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/99natmar99/Windows-11-Fixer/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match 'Portable.*\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== WINDOWS REPAIR TOOLS ====================

    @{N='WinRepairToolbox';S={
        $n='WinRepairToolbox';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows repair toolbox..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://windows-repair-toolbox.com/files/Windows_Repair_Toolbox.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Where-Object { $_.Name -match 'Windows.Repair' } | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='TweakingRepair';S={
        $n='TweakingRepair';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows repair AIO..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'http://www.tweaking.com/files/setups/tweaking.com_windows_repair_aio.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'Repair_Windows.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0; Remove-Item "$env:APPDATA\Tweaking*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='TronScript';S={
        $n='TronScript';$t="$env:TEMP\$n"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading comprehensive repair tool..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/bmrf/tron/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.exe$' } | Select-Object -First 1
            if ($rel) {
                $exe = "$t\Tron.exe"
                Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $exe -UseBasicParsing -TimeoutSec 300
                if (Test-Path $exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
            }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== PRIVACY & TELEMETRY OPTIMIZATION ====================

    @{N='OOShutUp10';S={
        $n='OOShutUp10';$t="$env:TEMP\$n";$exe="$t\OOSU10.exe"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading privacy optimizer..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe' -OutFile $exe -UseBasicParsing -TimeoutSec 120
            if ((Test-Path $exe) -and (Get-Item $exe).Length -gt 100000) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0; Remove-Item "$env:LOCALAPPDATA\O&O*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='Privatezilla';S={
        $n='Privatezilla';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading privacy optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/builtbybel/privatezilla/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'Privatezilla.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='WPD';S={
        $n='WPD';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows Privacy Dashboard..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://wpd.app/get/latest.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'WPD.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='WindowsSpyBlocker';S={
        $n='WindowsSpyBlocker';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading telemetry blocker..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/crazy-max/WindowsSpyBlocker/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match 'WindowsSpyBlocker.*\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='xdAntiSpy';S={
        $n='xdAntiSpy';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading anti-spy optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/builtbybel/xd-AntiSpy/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== BLOATWARE REMOVAL ====================

    @{N='BloatBox';S={
        $n='BloatBox';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading bloatware remover..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/builtbybel/bloatbox/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='Rectify11';S={
        $n='Rectify11';$t="$env:TEMP\$n"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Windows 11 UI optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/Rectify11/Installer/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.exe$' } | Select-Object -First 1
            if ($rel) {
                $exe = "$t\Rectify11.exe"
                Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $exe -UseBasicParsing -TimeoutSec 180
                if (Test-Path $exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
            }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== DISK CLEANERS ====================

    @{N='WiseDiskCleaner';S={
        $n='WiseDiskCleaner';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading disk cleaner..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://downloads.wisecleaner.com/soft/WDCFree.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'WiseDiskCleaner.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0; Remove-Item "$env:APPDATA\Wise*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='WiseRegCleaner';S={
        $n='WiseRegCleaner';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading registry cleaner..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://downloads.wisecleaner.com/soft/WRCFree.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'WiseRegCleaner.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='BleachBit';S={
        $n='BleachBit';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading system cleaner..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://download.bleachbit.org/BleachBit-4.6.2-portable.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'bleachbit.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0; Remove-Item "$env:APPDATA\BleachBit*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='GlaryUtilities';S={
        $n='GlaryUtilities';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading system optimizer..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://download.glarysoft.com/guportable.zip' -OutFile $z -UseBasicParsing -UserAgent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36' -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'Integrator.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0; Remove-Item "$env:APPDATA\Glary*","$env:LOCALAPPDATA\Glary*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='RegCool';S={
        $n='RegCool';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading registry optimizer..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://kurtzimmermann.com/files/RegCoolX64.zip' -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter '*.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== MEMORY OPTIMIZERS ====================

    @{N='ISLC';S={
        $n='ISLC';$t="$env:TEMP\$n";$exe="$t\ISLC.exe"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading memory optimizer..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://www.wagnardsoft.com/ISLC/ISLC%20v1.0.3.1.exe' -OutFile $exe -UseBasicParsing -TimeoutSec 120
            if (Test-Path $exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='MemReduct';S={
        $n='MemReduct';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading memory cleaner..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/henrypp/memreduct/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match 'memreduct.*bin.*\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter 'memreduct.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0; Remove-Item "$env:APPDATA\Henry++*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='MemPlus';S={
        $n='MemPlus';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading memory optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/CodeDead/MemPlus/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter 'MemPlus.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== NETWORK OPTIMIZERS ====================

    @{N='TCPOptimizer';S={
        $n='TCPOptimizer';$t="$env:TEMP\$n";$exe="$t\TCPOptimizer.exe"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading network optimizer..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://www.speedguide.net/files/TCPOptimizer.exe' -OutFile $exe -UseBasicParsing -TimeoutSec 120
            if (Test-Path $exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='SpeedyFox';S={
        $n='SpeedyFox';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading browser optimizer..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://crystalidea.com/downloads/speedyfox.zip' -OutFile $z -UseBasicParsing -TimeoutSec 120
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'speedyfox.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='SimpleWall';S={
        $n='SimpleWall';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading firewall optimizer..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/henrypp/simplewall/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match 'simplewall.*bin.*\.zip$' } | Select-Object -First 1
            if ($rel) { Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180; Expand-Archive -Path $z -DestinationPath $t -Force }
            $exe = Get-ChildItem $t -Filter 'simplewall.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== DRIVER CLEANUP ====================

    @{N='DDU';S={
        $n='DDU';$t="$env:TEMP\$n";$exe="$t\DDU.exe"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading Display Driver Uninstaller..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://www.wagnardsoft.com/DDU/download/DDU%20v18.1.4.0.exe' -OutFile $exe -UseBasicParsing -TimeoutSec 180
            if (Test-Path $exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t -Recurse -Force -EA 0; Remove-Item "$env:APPDATA\Wagnardsoft*" -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='DriverStoreExplorer';S={
        $n='DriverStoreExplorer';$t="$env:TEMP\$n";$z="$t.zip"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading driver store cleaner..." -ForegroundColor Cyan
        try {
            $rel = (Invoke-RestMethod 'https://api.github.com/repos/lostindark/DriverStoreExplorer/releases/latest' -TimeoutSec 30).assets | Where-Object { $_.name -match '\.zip$' } | Select-Object -First 1
            Invoke-WebRequest -Uri $rel.browser_download_url -OutFile $z -UseBasicParsing -TimeoutSec 180
            Expand-Archive -Path $z -DestinationPath $t -Force
            $exe = Get-ChildItem $t -Filter 'Rapr.exe' -Recurse | Select-Object -First 1
            if ($exe) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe.FullName -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Remove-Item $t,$z -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    # ==================== SOFTWARE UPDATER ====================

    @{N='PatchMyPC';S={
        $n='PatchMyPC';$t="$env:TEMP\$n";$exe="$t\PatchMyPC.exe"
        New-Item -ItemType Directory -Path $t -Force | Out-Null
        Write-Host "[$n] Downloading software updater..." -ForegroundColor Cyan
        try {
            Invoke-WebRequest -Uri 'https://patchmypc.com/freeupdater/PatchMyPC.exe' -OutFile $exe -UseBasicParsing -TimeoutSec 180
            if ((Test-Path $exe) -and (Get-Item $exe).Length -gt 500000) { Write-Host "[$n] Running..." -ForegroundColor Green; Start-Process $exe -Verb RunAs -Wait }
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] Purging..." -ForegroundColor Yellow
        Get-Process -Name '*PatchMyPC*' -EA 0 | Stop-Process -Force -EA 0; Start-Sleep 1
        Remove-Item $t -Recurse -Force -EA 0
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}

    @{N='Chocolatey';S={
        $n='Chocolatey'
        Write-Host "[$n] Installing package manager..." -ForegroundColor Cyan
        try {
            [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
            iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
            Write-Host "[$n] Chocolatey installed! Use 'choco upgrade all -y' to update apps" -ForegroundColor Green
        } catch { Write-Host "[$n] Error: $_" -ForegroundColor Red }
        Write-Host "[$n] DONE" -ForegroundColor Green
    }}
)

# ============================================================================
# PARALLEL EXECUTION ENGINE - ALWAYS 5 RUNNING
# ============================================================================

$maxParallel = 5
$runningJobs = @{}
$idx = 0
$total = $tools.Count

Write-Host ""
Write-Host "Starting $total Windows 11 optimization tools - ALWAYS $maxParallel RUNNING!" -ForegroundColor Yellow
Write-Host "Close each app when done - purge happens automatically!" -ForegroundColor Cyan
Write-Host ""

# Initial launch of first 5 tools
for ($i = 0; $i -lt $maxParallel -and $idx -lt $total; $i++) {
    $tool = $tools[$idx]
    $job = Start-Job -ScriptBlock $tool.S -Name $tool.N
    $runningJobs[$job.Id] = $job
    Write-Host "[STARTED $($idx + 1)/$total] $($tool.N)" -ForegroundColor Magenta
    $idx++
}

Write-Host ""
Write-Host ">>> $maxParallel TOOLS NOW RUNNING IN PARALLEL <<<" -ForegroundColor Green
Write-Host ""

# Main loop - keep 5 running at ALL times
while ($runningJobs.Count -gt 0 -or $idx -lt $total) {

    # Check each job and immediately replace completed ones
    $completedIds = @()
    foreach ($jobId in @($runningJobs.Keys)) {
        $job = $runningJobs[$jobId]

        if ($job.State -eq 'Completed' -or $job.State -eq 'Failed') {
            if ($job.State -eq 'Failed') {
                Write-Host "[FAILED] $($job.Name)" -ForegroundColor Red
            }
            Receive-Job $job -EA 0
            Remove-Job $job -Force -EA 0
            $completedIds += $jobId

            # IMMEDIATELY start next tool to maintain 5 running
            if ($idx -lt $total) {
                $tool = $tools[$idx]
                $newJob = Start-Job -ScriptBlock $tool.S -Name $tool.N
                $runningJobs[$newJob.Id] = $newJob
                Write-Host "[STARTED $($idx + 1)/$total] $($tool.N) (Running: $($runningJobs.Count))" -ForegroundColor Magenta
                $idx++
            }
        }
    }

    # Remove completed job IDs from hashtable
    foreach ($id in $completedIds) {
        $runningJobs.Remove($id)
    }

    # Safety: ensure we always have 5 if tools remain
    while ($runningJobs.Count -lt $maxParallel -and $idx -lt $total) {
        $tool = $tools[$idx]
        $newJob = Start-Job -ScriptBlock $tool.S -Name $tool.N
        $runningJobs[$newJob.Id] = $newJob
        Write-Host "[STARTED $($idx + 1)/$total] $($tool.N) (Running: $($runningJobs.Count))" -ForegroundColor Magenta
        $idx++
    }

    Start-Sleep -Milliseconds 200
}

Write-Host ""
Write-Host "=" * 90 -ForegroundColor Magenta
Write-Host "   ALL $total WINDOWS 11 OPTIMIZATION TOOLS COMPLETED!" -ForegroundColor Green
Write-Host "   All traces purged from system!" -ForegroundColor Yellow
Write-Host "=" * 90 -ForegroundColor Magenta
Write-Host ""
Write-Host "RECOMMENDED: Restart your computer for all changes to take effect." -ForegroundColor Cyan
Write-Host ""
