#Requires -Version 3.0

<#
  Use-SPClientType.ps1

  Copyright (c) 2017 karamem0

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
#>

function Use-SPClientType {

<#
.SYNOPSIS
  Loads SharePoint Client Components assemblies.
.DESCRIPTION
  The Use-SPClientType function loads SharePoint Client Components assemblies.
    - Microsoft.SharePoint.Client.dll
    - Microsoft.SharePoint.Client.Runtime.dll
.PARAMETER LiteralPath
  Indicates the path that locates SharePoint Client Components. If not
  specified, loads from the location below.
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
