[CmdletBinding()]
param(
    [Parameter(Mandatory, Position=0)][string]$InputFile,
    [string]$OutputFile
)
$ErrorActionPreference = 'Stop'
$culture = [Globalization.CultureInfo]::InvariantCulture
try {
    $records = @(Get-Content -LiteralPath $InputFile -Encoding utf8 | ForEach-Object { $_.Trim() } | Where-Object { $_ })
    if (-not $records.Count) { throw 'The input file is empty.' }
    $result = @(& {
        [long]$seconds = 0
        foreach ($line in $records) {
            if ($line -notmatch '^(\d+):([0-5]\d)\s*\|\s*(.+)$') { throw 'Expected mm:ss | title.' }
            '{0}:{1:00} {2}' -f [math]::Floor($seconds/60), ($seconds%60), $Matches[3]
            $seconds += [long]$Matches[1]*60 + [int]$Matches[2]
        }
    })
    if ($OutputFile) {
        $stream = [IO.File]::Open([IO.Path]::GetFullPath($OutputFile), 'CreateNew', 'Write')
        try {
            $bytes = [Text.Encoding]::UTF8.GetBytes(($result -join [Environment]::NewLine) + [Environment]::NewLine)
            $stream.Write($bytes, 0, $bytes.Length)
        } finally { $stream.Dispose() }
    } else { $result }
} catch {
    [Console]::Error.WriteLine($_.Exception.Message)
    exit 1
}
