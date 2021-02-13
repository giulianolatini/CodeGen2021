# CodeGen2021 Memo Notes

## Prerequisite

[Installing Chocolatey](https://chocolatey.org/install)
[Packages](https://chocolatey.org/packages)
[Firefox Developer Edition](https://www.mozilla.org/it/firefox/developer/)

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

refreshenv

choco install -y googlechrome
choco install -y microsoft-edge
choco install -y firefox
choco install -y cascadia-code-nerd-font
choco install -y cascadiafonts
choco install -y firacodenf
choco install -y vscode
choco install -y gpg4win
choco install -y git
choco install -y microsoft-windows-terminal
choco install -y powershell
choco install -y powershell-core
choco install -y dotnetcore-sdk
choco install -y dotnet-sdk
choco install -y openssh
```

Enable Windows Subsystem Linux Feature

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
#--- or ---
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

wsl --set-default-version 2

Invoke-WebRequest -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile wsl_update_x64.msi -UseBasicParsing

Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile Ubuntu.appx -UseBasicParsing

Add-AppxPackage .\Ubuntu.appx
```

[JanDeDobbeleer/oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh)
Run as Administrator:
Set policy to RemoteSigned

```powershell
Set-ExecutionPolicy RemoteSigned
Install-Module -Name PowerShellGet -Force

# Uninstall the OpenSSH Client
Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Uninstall the OpenSSH Server
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# If installed OpenSSH-Win64 after OpenSSH
Remove from Variable PATH of System Environment 'C:\Program Files\OpenSSH\bin' and add 'C:\Program Files\OpenSSH-Win64'
and reboot system

choco install -y openssh
# Install windows services sshd and ssh-agent
. "C:\Program Files\OpenSSH-Win64\install-sshd.ps1"
Stop-Service OpenSSHd
Stop-Service sshd
Set-Service OpenSSHd -StartupType Disabled
Set-Service sshd -StartupType Manual
Set-Service SSH-Agent -StartupType Automatic
Start-Service ssh-agent

Exit
```

```powershell
Install-Module posh-docker -Scope CurrentUser
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module PSReadLine -Scope CurrentUser
Install-Module WindowsPSModulePath

Install-Module posh-docker 
Install-Module posh-git 
Install-Module oh-my-posh 
Install-Module PSReadLine 
Install-Module WindowsPSModulePath


choco install -y docker-desktop
```

Create ed enable SSH and GPG keys for Git

* [Setting up SSH and Git on Windows 10](https://dev.to/bdbch/setting-up-ssh-and-git-on-windows-10-2khk#:~:text=The%20service%20will%20be%20disabled,your%20console%20via%20ssh%2Dagent%20.&text=Now%20you%20will%20have%20both%20keys%20available%20for%20this%20session.)

* [Signing Git Commits and Tags with GPG](https://jigarius.com/blog/signing-git-commits#:~:text=Add%20GPG%20keys%20to%20Git%20repository%20manager&text=The%20option%20to%20add%20your,it%20to%20your%20repository%20manager.)

```powershell

# Create ed25519 key
ssh-keygen -t ed25519 -C "giulianolatini@codegen2021.it" -f $HOME\.ssh\giulianolatini@codegen2021.it
# Add key to agent
ssh-add $HOME\.ssh\giulianolatini@codegen2021.it
# copy public key to clipboard 
cat $HOME\.ssh\giulianolatini@codegen2021.it.pub | clip
# Add the public key to SSH and GPG section into Github's setting

# Generated keys by questions&answears
gpg --full-generate-key

# short version listing keys
gpg --list-secret-keys

# long version keys when list they
gpg --list-secret-keys --keyid-format LONG

# export public key
gpg --armor --export YOUR_GPG_KEY | clip
gpg --armor --export-secret-key YOUR_GPG_KEY | clip 

# send key to public keyservers
gpg --send-keys YOUR_GPG_KEY_ID
gpg --keyserver pgp.mit.edu --send-keys YOUR_GPG_KEY_ID
gpg --keyserver keyserver.ubuntu.com --send-keys YOUR_GPG_KEY_ID
```

Add Visual Studio Code configs file

```powershell
git a -f .vscode\User\settings.json
git a -f .vscode\extensions.json
git a -f .vscode\launch.json
git a -f .vscode\tasks.json
```
