# README

App Tables

## User Table

* id : int
* name : string
* email : string
* password : string

## Task Table

* id : int
* title : string
* description : text
* state : int
* doingDate : Date
* priority : int
* user_id : int

## Tag Table

* id :int
* title : string 

## Differents step of deployment

* First Create an heroku app 
* Next precompile assets for production environment
* Next, Do a commit with git
* Add Heroku buildpack
* Finally deploy to heroku with git push command


