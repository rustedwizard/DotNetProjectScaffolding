# DotNetProjectScaffolding
Simple PowerShell Script used to scaffolding a dotnet core project and add it to git repository

## Intro
This repo contians a simple PowerShell script which wil perform following steps:

1. Invoke dotnet tool to create a project using supplied project name, project template name and project language (optional, default to C# if not supplied)
2. Copy a default .gitignore file into project root folder.
3. Initializing a git repository
4. Add files to the repo and commit with message "Initial Project Creation"
5. Open the project folder in VSCode

## Usage:
There is not installation required, just put the script dotnet-project-scaffolding.ps1 and the dps-file folder into PowerShell Script folder then you ar all setup. 

To change gitignore file, go into folder dps-file, modify .gitignore file there.

To use this script simple type dotnet-project-scaffolding.ps1 -Project_Type console -Project_Name HelloWorld -Language C#.

Project_Type and the Language takes the same value as you would supply to dotnet command line tool. 
