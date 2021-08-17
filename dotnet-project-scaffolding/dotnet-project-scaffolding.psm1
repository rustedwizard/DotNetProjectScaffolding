function Open_In_Code{
    #if Visual Studio code is not found, then abort!
    if ($null -eq (Get-Command "code.cmd" -ErrorAction Stop)) {
        Write-Host "Scafolding is complete, but Visual Studio Code is not detected on your computer, so it will not be started."
    }
    code . -n
}

function Check_DotNet{
    #If dotnet tool is not found, then abort!
    if ($null -eq (Get-Command "dotnet.exe" -ErrorAction Stop)) {
        Write-Host "It seems dotnet is not installed or in your PATH"
    }
}

function Check-Git{
    #if git is not found stop initializing repo, call Open in code function
    if ($null -eq (Get-Command "git.exe" -ErrorAction Stop)) {
        Write-Host "Scafolding is done, but Git could not be found on this machine, stop adding the project to Version Control"
        Write-Host "Attempting to open project in Visual Studio Code..."
        Open_In_Code
    }
}
function New-dotNetProject {
    param(
        [Parameter(Mandatory = $true)]
        $Project_Type,
        [Parameter(Mandatory = $true)]
        $Project_Name,
        [Parameter(Mandatory = $false)]
        $Language = 'C#'
    )

    #Creating new project
    Write-Host "Creatint new dotnet project..."
    $null = Check_DotNet
    dotnet new $Project_Type --language $Language --output $Project_Name

    $currentLocation = Get-Location;
    Set-Location $currentLocation/$Project_Name;

    #Put the project under version control
    Write-Host "Initializing version control..."
    $null = Check-Git
    $null = Copy-Item -Path $PSScriptRoot/gitignore -Destination $currentLocation/$Project_Name
    $null = Rename-Item $currentLocation/$Project_Name/gitignore -NewName .gitignore
    $null = git init
    $null = git add .
    Write-Host "Commit for the first time..."
    $null = git commit -m "Initial Project Creation"

    #call open in code function
    Write-Host "Attempting to open project in Visual Studio Code..."
    $null = Open_In_Code

    Write-Host "Project scaffolding Complete!"
}

function New-dotNetSolution{
    #Create new Solution
    $null = Check_DotNet
    dotnet new sln

    $currentLocation = Get-Location
    $null = Copy-Item -Path $PSScriptRoot/gitignore -Destination $currentLocation
    $null = Rename-Item $currentLocation/gitignore -NewName .gitignore
    While($true){
        $ans = Read-Host -Prompt "Do you need create new project [y/n]: "
        if($ans -eq "y"){
            $ptype = ReadHost -Prompt "Please enter project type: "
            $pname = ReadHost -Prompt "Please enter project name: "
            $plang = ReadHost -Prompt "Please enter programming language (default is C#):"
            if($plang -eq ""){
                $plang = "C#"
            }
            WriteHost "Creating new project ..."
            dotnet new $ptype --language $plang -n $pname
            WriteHost "Hook the project with solution ..."
            dotnet sln add $Project_Name
            continue
        }
        if($ans -eq "n"){
            break
        }
        Write-Host "Please enter an valid answer [y/n]"
    }
    Write-Host "Initializing Version Control ..."
    $null = Check-Git
    $null = git init
    $null = git add . 
    Write-Host "Commit for the first time..."
    $null = git commit -m "Initial Solution Creation"

    #Attempting to open in visual studio code
    Write-Host "Attempting to open project in Visual Studio Code..."
    $null = Open_In_Code
}

Export-ModuleMember -Function New-dotNetProject, New-dotNetSolution

