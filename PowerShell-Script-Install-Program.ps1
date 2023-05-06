$programsInstalled = Invoke-Expression "winget list"
$programList = Get-Content "program-list.txt"

function InstallProgram
{
    param(
        [Parameter(Mandatory=$true)]
        [string]$programID
    )

    For($index = 0; $index -le $programsInstalled.Length; $index++)
    {
        if($programID -ne "" -or $programID -ne " " -and $programID -notmatch "^\s*$") # is it a whitespace? alt: 
        {
            if($programsInstalled[$index] -ne $null)
            {
                if($programsInstalled[$index].Contains($programID)) # $stringToSearch.Trim() -cmatch "^$([regex]::Escape($searchString))"
                {
                    # Write-Host "$($programID) has been installed"
                    Invoke-Expression "winget install $($programID) --accept-source-agreements"
                    break
                }
            }
        }
    }
}

$programs = New-Object int[] $programsInstalled.Length

foreach ($newProgram in $programList)
{
    InstallProgram($newProgram)
}