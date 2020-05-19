##Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
##choco install ServiceBusExplorer
$objShell = New-Object -ComObject ("WScript.Shell")
$objShortCut = $objShell.CreateShortcut($env:ProgramData + "\Microsoft\Windows\Start Menu\Programs\Service Bus Explorer.lnk")
$objShortCut.TargetPath = $env:ChocolateyInstall + "\lib\ServiceBusExplorer\tools\ServiceBusExplorer.exe"
$objShortCut.Save()