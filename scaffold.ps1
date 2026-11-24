param(
    [string]$TargetPath = $PSScriptRoot
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($TargetPath)) {
    $TargetPath = (Get-Location).Path
}

New-Item -ItemType Directory -Path $TargetPath -Force | Out-Null
$root = (Resolve-Path -LiteralPath $TargetPath).Path

$modules = @(
    'Module 01 - Information Security Threats and Vulnerabilities'
    'Module 02 - Information Security Attacks'
    'Module 03 - Network Security Fundamentals'
    'Module 04 - Identification, Authentication and Authorization'
    'Module 05 - Network Security Controls - Administrative Controls'
    'Module 06 - Network Security Controls - Physical Controls'
    'Module 07 - Network Security Controls - Technical Controls'
    'Module 08 - Network Security Assessment Techniques and Tools'
    'Module 09 - Application Security'
    'Module 10 - Virtualization and Cloud Computing'
    'Module 11 - Wireless Network Security'
    'Module 12 - Mobile Device Security'
    'Module 13 - IoT and OT Security'
    'Module 14 - Cryptography'
    'Module 15 - Data Security'
    'Module 16 - Network Troubleshooting'
    'Module 17 - Network Traffic Monitoring'
    'Module 18 - Network Logs Monitoring and Analysis'
    'Module 19 - Incident Response'
    'Module 20 - Computer Forensics'
    'Module 21 - Business Continuity and Disaster Recovery'
    'Module 22 - Risk Management'
)

function New-TrackedLeafDirectory {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][string]$Description
    )

    New-Item -ItemType Directory -Path $Path -Force | Out-Null
    $placeholder = Join-Path $Path '.gitkeep'

    if (-not (Test-Path -LiteralPath $placeholder)) {
        $utf8WithoutBom = New-Object System.Text.UTF8Encoding($false)
        [System.IO.File]::WriteAllText($placeholder, "# $Description`n", $utf8WithoutBom)
    }
}

New-TrackedLeafDirectory -Path (Join-Path $root 'Wrap Up') -Description 'Wrap-up materials and course completion notes.'

foreach ($module in $modules) {
    $modulePath = Join-Path $root $module
    New-Item -ItemType Directory -Path $modulePath -Force | Out-Null

    New-TrackedLeafDirectory -Path (Join-Path $modulePath 'Notes') -Description "Notes, summaries, and timestamp-linked cues for $module."
    New-TrackedLeafDirectory -Path (Join-Path $modulePath 'Labs') -Description "Lab walkthroughs, screenshots, and configurations for $module."
    New-TrackedLeafDirectory -Path (Join-Path $modulePath 'Exercises') -Description "Practice questions and review items for $module."
}

Write-Host "CCT study structure created under: $root"
