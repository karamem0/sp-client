#Requires -Version 3.0

<#
  Use-SPClientType.ps1

  Copyright (c) 2017 karamem0

  This software is released under the MIT License.
  https://github.com/karamem0/SPClient/blob/master/LICENSE
#>

function Use-SPClientType {

<#
.SYNOPSIS
  Loads SharePoint client components assemblies.
.DESCRIPTION
  The Use-SPClientType function loads SharePoint client components assemblies.
    - Microsoft.SharePoint.Client.dll
    - Microsoft.SharePoint.Client.Runtime.dll
  Usually, this function is called first in your script.
.PARAMETER LiteralPath
  Indicates the path that locates SharePoint client components. If not specified, loads from the location below.
    - Current working directory
    - Global assembly cache (GAC)
.PARAMETER PassThru
  If specified, returns loaded assemblies.
.EXAMPLE
  Use-SPClientType
.EXAMPLE
  Use-SPClientType -LiteralPath "C:\Users\admin\Documents"
.INPUTS
  None or System.String
.OUTPUTS
  None or System.Reflection.Assembly[]
.LINK
  https://github.com/karamem0/SPClient/blob/master/doc/Use-SPClientType.md
#>

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true)]
        [string]
        $LiteralPath,
        [Parameter(Mandatory = $false)]
        [switch]
        $PassThru
    )

    process {
        $AssemblyNames = @(
            'Microsoft.SharePoint.Client'
            'Microsoft.SharePoint.Client.Runtime'
        )
        $AssemblyPaths = @()
        if ($PSBoundParameters.ContainsKey('LiteralPath')) {
            if (Test-Path -Path $LiteralPath) {
                foreach ($AssemblyName in $AssemblyNames) {
                    $AssemblyPath = Join-Path -Path $LiteralPath -ChildPath "$($AssemblyName).dll"
                    if (Test-Path -Path $AssemblyPath) {
                        $AssemblyPaths += $AssemblyPath
                    }
                }
            }
        }
        if ($AssemblyNames.Length -ne $AssemblyPaths.Length) {
            $AssemblyPaths.Clear()
            $LiteralPath = Get-Location
            foreach ($AssemblyName in $AssemblyNames) {
                $AssemblyPath = Join-Path -Path $LiteralPath -ChildPath "$($AssemblyName).dll"
                if (Test-Path -Path $AssemblyPath) {
                    $AssemblyPaths += $AssemblyPath
                }
            }
        }
        if ($AssemblyNames.Length -ne $AssemblyPaths.Length) {
            $AssemblyPaths.Clear()
            $LiteralPath = "$($Env:WinDir)\Microsoft.NET\Assembly\GAC_MSIL"
            foreach ($AssemblyName in $AssemblyNames) {
                $AssemblyPath = Join-Path -Path $LiteralPath -ChildPath "$($AssemblyName)"
                $AssemblyPath = Get-ChildItem -Path $AssemblyPath -Recurse |
                    Where-Object { $_.Extension -eq '.dll' } |
                    ForEach-Object { $_.FullName } |
                    Sort-Object -Descending |
                    Select-Object -First 1
                $AssemblyPaths += $AssemblyPath
            }
        }
        if ($AssemblyNames.Length -ne $AssemblyPaths.Length) {
            throw 'Cannot find SharePoint Client Component assemblies.'
        }
        $Assemblies = $AssemblyPaths | ForEach-Object { [System.Reflection.Assembly]::LoadFrom($_) }
        Get-ChildItem -Path $SPClient.ModulePath -Recurse |
            Where-Object { -not $_.FullName.Contains('.Tests.') } |
            Where-Object { $_.Extension -eq '.cs' } |
            ForEach-Object { Add-Type -Path $_.FullName -ReferencedAssemblies $Assemblies }
        if ($PassThru) {
            Write-Output $Assemblies
        }
    }

}
