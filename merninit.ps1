#This Script is used to create a MERN Stack Boiler-Plate
#To run, navigate to directory where you want to create your project
#Open PowerShell, run this script from current directory

#Create Project Directory
mkdir project

#Navigate to project directory
Set-Location project/

#Create a logging file
New-Item -Path . -Name 'ScriptLog.txt' -ItemType 'file'

#Declare variables
$LogFile =  ".\ScriptLog.txt"
$Express = "const express = require('express');"
$Mongoose = "const mongoose = require('mongoose');"
$App = "const app = express();"
$Route = "app.get('/', (req, res) => {res.render('Hello World!')});"
$PORT = "const PORT = process.env.PORT || 5000;`r`n"
$Listen = "app.listen(PORT, () => console.log(``Server started on port: `${PORT}``))"
$DB = "mongoose.connect(db, {useNewUrlParser:true, useUnifiedTopology: true, useCreateIndex: true}).then(() => console.log('MongoDB Connected...')).catch(err => console.log(err));"
$DBConfig = "const db = config.get('database');`r`n"
$Config = "const config = require('config');`r`n"

#Create Logging Function
function LogMessage
{
    param([string]$Message)

    ((Get-Date).ToString() + " - " + $Message) >> $LogFile;
}
LogMessage -Message 'Logging System Created'

#Initializes Node.js
npm init -y
LogMessage -Message 'Node init complete'

#Install Server Side Dependencies
#I listed basic modules I use often, feel free to customize to your needs
#This is by no means comprehensive or even recommended, use personal judgement
npm i --save express mongoose config dotenv bcryptjs concurrently jsonwebtoken
npm i --save-dev nodemon
LogMessage -Message 'dependencies installed'

#Check for vulnerabilities and fixes where possible
npm audit fix

#Create Initial App Structure
#Step One, Create Git Ignore and ReadMe Files
New-Item -Path . -Name '.gitignore' -ItemType 'file' -Value ".env `r`nnode_modules `r`npackage-lock.json `r`nScriptLog.txt `r`n\config"
New-Item -Path . -Name 'README.md' -ItemType 'file' -Value '# Welcome to your MERN Stack App'
LogMessage -Message 'Created git ignore and read me files'

#Step Two, Create Express Server
#This is very basic boiler plate intended to be built upon
New-Item -Path . -Name 'index.js' -ItemType 'file' -Value "//Server entry file`r`n"
Add-Content -Path .\index.js -Value "$Express`r`n$Mongoose`r`n$Config`r`n$App`r`n$DBConfig`r`n$DB`r`n$Route`r`n$PORT`r`n$Listen"
LogMessage -Message 'Created Express Server'

#Step Three, Create App Directory Structure
New-Item -Path . -Name 'api' -ItemType 'directory'
New-Item -Path .\api -Name "routes" -ItemType 'directory'
New-Item -Path .\api -Name 'models' -ItemType 'directory'
New-Item -Path . -Name 'client' -ItemType 'directory'
New-Item -Path . -Name 'config' -ItemType 'directory'
LogMessage -Message 'Directories created'

#Step Four, Create Config file
#This file is used to hide secure info using the config module
#Fill in fields between < and >
New-Item -Path .\config\ -Name 'default.json' -ItemType 'file' -Value "{`"database`": `"<MongoUri>`",`"jwtSecret`": `"<SecretToken>`"}"
LogMessage -Message 'created config file'

#Step Five, Create Boiler Plate for Routes and models
#This step WILL need reworked for your specific application
#Basic code only
New-Item -Path .\api\models -Name "Item.js" -ItemType "file" -Value "//Basic Item Model`r`nconst mongoose = require('mongoose');`r`nconst Schema = mongoose.Schema;`r`n`r`nconst ItemSchema = new Schema({ name: { type: String, required: true }, date: { type: Date, default: Date.now } });`r`n`r`nmodule.exports = Item = mongoose.model('item', ItemSchema);"
New-Item -Path .\api\routes -Name 'items.js' -ItemType 'file' -Value "//Basic Routes`r`nconst express = require('express');`r`nconst router = express.Router();`r`n`r`n//Item Model`r`nconst Item = require('../models/Item.js')`r`nrouter.get('/', (req, res) => { Item.find().sort({ date: -1 }).then(items => res.status(200).json(items)).catch(err => console.log(err)) });`r`n`r`nmodule.exports = router;"

#Creates initial GIT Repository
git init
git add .
git commit -m 'Initial Commit'

#Begin Building Client Side React App
#Move to Client Directory
Set-Location client/

#Use NPX to build React template
npx create-react-app .

#Installed dependencies
#Again, edit for personal use
npm i --save-dev uuid
npm i --save axios react-router-dom react-transition-group reactstrap react-redux redux redux-thunk
LogMessage -Message 'client dependencies installed'

#Check for vulnerabilities and fixes where possible
npm audit fix

#Move out of Client directory
Set-Location ../
LogMessage -Message "React App template created"

#GIT Commit with Boilerplate complete
git add .
git commit -m 'Basic App Created by Script'

#Move out of project directory
Set-Location ../
LogMessage -Message 'Script Complete'



