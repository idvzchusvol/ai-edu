Function global:ADD-PATH() {
    [Cmdletbinding()]
    param
    ( 
        [parameter(Mandatory=$True,
           ValueFromPipeline=$True,
           Position=0)]
           [String[]]$AddedFolder
    )

    $OldPath=(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).Path

    If (!$AddedFolder)
    { Return "No Folder Supplied. " + $ENV:PATH + "Unchanged"}

    If (!(TEST-PATH $AddedFolder))
    { Return "Folder Does not Exist, Cannot be added to " + $ENV:PATH }

    If ($ENV:PATH | Select-String -SimpleMatch $AddedFolder)
    { Return "Folder already within " + $ENV:PATH }

    $NewPath=$OldPath+';'+$AddedFolder

    Return $NewPath
}

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
choco install docker-for-windows git python3 googlechrome vscode pycharm -y
$h=hostname
ipconfig | select-string -pattern "  IPv4 "|format-table @{Expression={$_.Line};Label="$h IPs"}
choco -v
docker -v
git --version
$newpath = ADD-PATH -addedfolder C:\python37
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath
python -m pip install pip --upgrade
python -m pip install numpy
python -m pip install matplotlib
mkdir C:\training
cd C:\traning
invoke-webrequest https://raw.githubusercontent.com/microsoft/ai-edu/mpp/C-%E5%BC%80%E5%8F%91%E5%B7%A5%E5%85%B7%E4%B8%8E%E7%8E%AF%E5%A2%83/mpp/run.ps1 -outfile C:\training\run.ps1
git clone https://github.com/bartuer/training_notebook.git
cd training_notebook
git pull
cd ..
Write-Host "configure docker volume, share C folder, then restart machine"
Write-Host "after rebooting, run.ps1"
