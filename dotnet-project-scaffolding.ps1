param(
    [Parameter(Mandatory = $true)]
    $Project_Type,
    [Parameter(Mandatory = $true)]
    $Project_Name,
    [Parameter(Mandatory = $false)]
    $Language='C#'
)

#Open in visual studio code
function Open_In_Code {
    #if Visual Studio code is not found, then abort!
    if ($null -eq (Get-Command "code.cmd" -ErrorAction Stop)) {
        Write-Host "Project scafolding is complete, but Visual Studio Code is not detected on your computer, so it will not be started."
    }
    code . -n
}

#Creating new project
Write-Host "Creatint new dotnet project..."
#If dotnet tool is not found, then abort!
if ($null -eq (Get-Command "dotnet.exe" -ErrorAction Stop)) {
    Write-Host "It seems dotnet is not installed or in your PATH"
}
dotnet new $Project_Type --language $Language --output $Project_Name

$currentLocation = Get-Location;
Set-Location $currentLocation/$Project_Name;

#Put the project under version control
Write-Host "Initializing version control..."
#if git is not found stop initializing repo, call Open in code function
if ($null -eq (Get-Command "git.exe" -ErrorAction Stop)) {
    Write-Host "Project scafolding is done, but Git could not be found on this machine, stop adding the project to Version Control"
    Write-Host "Attempting to open project in Visual Studio Code..."
    Open_In_Code
}
$null = Copy-Item -Path $PSScriptRoot/dps-file/.gitignore -Destination $currentLocation/$Project_Name
$null = git init
$null = git add .
Write-Host "Commit for the first time..."
$null = git commit -m "Initial Project Creation"

#call open in code function
Write-Host "Attempting to open project in Visual Studio Code..."
Open_In_Code

Write-Host "Project scafolding Complete!"

