# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Powerlevel10k-Lean
$ThemeSettings.Colors.DriveForegroundColor = [ConsoleColor]::Green
$ThemeSettings.Colors.DriveForegroundColor = [ConsoleColor]::White
$ThemeSettings.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x25B7)
$ThemeSettings.PromptSymbols.ElevatedSymbol = [char]::ConvertFromUtf32(0x25C2)
$ThemeSettings.GitSymbols.BranchSymbol = [char]::ConvertFromUtf32(0x2642)

function ProjectIDE {
  param ( 
    $RootProjectPath
  )
  
  if (!$RootProjectPath) {
    Write-Host ("needed the project root path ")
  }
  else {
    $CmdLineArguments = ""
    $CmdLineArguments = " --user-data-dir=" + $RootProjectPath + "\.vscode"
    [String]$CmdLineArguments = $CmdLineArguments + " --extensions-dir=" + $RootProjectPath + "\.vscode\extensions"
    $ProcessInfo = New-Object System.Diagnostics.ProcessStartInfo 
    $ProcessInfo.FileName = "${ENV:ProgramFiles}\Microsoft VS Code\Code.exe" 
    $ProcessInfo.RedirectStandardError = $true 
    $ProcessInfo.RedirectStandardOutput = $true 
    $ProcessInfo.UseShellExecute = $False 
    $ProcessInfo.Arguments = "$CmdLineArguments"
    $ProcessInfo.CreateNoWindow = $False
    $ProcessInfo.Verb = "runas"
    $Process = New-Object System.Diagnostics.Process 
    $Process.StartInfo = $ProcessInfo
    $Process.Start() | Out-Null
    #$Process.WaitForExit()
    $Output = $Process.StandardOutput.ReadToEnd()
    $Output
  }
}

Set-Alias -Name "code-prj" -Value ProjectIDE

if ($host.Name -eq 'ConsoleHost') {
  Import-Module PSReadLine
  Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
  Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
  Set-PSReadLineKeyHandler -Key Tab -Function Complete
  Set-PSReadLineKeyHandler -Chord 'Oem7','Shift+Oem7' `
                           -BriefDescription SmartInsertQuote `
                           -LongDescription "Insert paired quotes if not already on a quote" `
                           -ScriptBlock {
      param($key, $arg)
  
      $line = $null
      $cursor = $null
      [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
  
      if ($line[$cursor] -eq $key.KeyChar) {
          # Just move the cursor
          [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor + 1)
      }
      else {
          # Insert matching quotes, move cursor to be in between the quotes
          [Microsoft.PowerShell.PSConsoleReadLine]::Insert("$($key.KeyChar)" * 2)
          [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
          [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($cursor - 1)
      }
  }
}
