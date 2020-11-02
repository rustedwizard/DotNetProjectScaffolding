# DotNetProjectScaffolding
Simple PowerShell module used to scaffolding a dotnet core project and add it to git repository

## Intro
This repo contians a simple PowerShell script which wil perform following steps:

1. Invoke dotnet tool to create a project using supplied project name, project template name and project language (optional, default to C# if not supplied)
2. Copy a default .gitignore file into project root folder.
3. Initializing a git repository
4. Add files to the repo and commit with message "Initial Project Creation"
5. Open the project folder in VSCode

## Usage:
Setup is very simple, put the folder dotnet-project-scaffolding and everything in it into one of your PowerShell module (You can check with PowerShell Command $env:PSModulePath).

To change gitignore file, go into folder dps-file, modify .gitignore file there.

To use this module simple type New-dotNetProject -Project_Type console -Project_Name HelloWorld -Language C#.

Project_Type and the Language takes the same value as you would supply to dotnet command line tool. 
