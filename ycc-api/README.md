# YCC-API

This is the main repository for the rest api serving data for the ycc events app, a project originally created by 
students in the INFOTC 4500 class at the University of Missouri in 2018.


## Installation

1. `git clone [repository link]`
2. `cd ycc-api`
3. `npm install`
4. [Install a mongodb instance on the server](https://docs.mongodb.com/manual/installation/)

## Configuration

Create a file called `config.json`  in the root project folder with the following configuration:

```
{
  "isProduction": [true or false],
  "address": [public address of the server],
  "mongoDbAddress": [mongoDb instance address],
  "port": [port for the server to run on],
  "passportSecret": [secret for token encryption],
  "nodemailerConfig": [object for nodemailer configuration]
}
```
 * **isProduction** boolean value indicating whether the server is running in production or not. If the server is
 not being run in production, useful error messages will be given along with a `500 Internal Server Error` response
 
 * **address** string value of the address the server is running on. This is needed for creating the link in the
 email verification
  
 * **mongoDbAddress** string value of the address to the local mongodb instance. This will most likely be 
 `"mongodb://localhost/ycc-api"`
  
 * **port** number value indicating what port the server should run on
  
 * **passportSecret** string value to use for encrypting tokens, can be any value
  
 * **nodemailerConfig** an object for configuring the email service. [Documentation here](https://nodemailer.com/smtp/)


**Example**

```json
{
  "isProduction": true,
  "address": "http://localhost:8000",
  "mongoDbAddress": "mongodb://localhost/ycc-api",
  "port": 8000,
  "passportSecret": "pizza",
  "nodemailerConfig": {
    "service": "gmail",
    "auth": {
      "user": "test@gmail.com",
      "pass": "test1234"
    }
  }
}
```

## API Documentation

##### Auth

* [Login](/docs/auth/login.md)
* [Register](/docs/auth/register.md)
* [Validate](/docs/auth/validate.md)

##### Category

Endpoints for getting and manipulating event categories
* [delete](/docs/category/delete.md)
* [get](/docs/category/get.md)
* [post](/docs/category/post.md)

##### Event

Endpoints for getting and manipulating upcoming and past events
* [delete](/docs/event/delete.md)
* [get](/docs/event/get.md)
* [post](/docs/event/post.md)

##### Location

Endpoints for getting and manipulating locations associated with events
* [delete](/docs/location/delete.md)
* [get](/docs/location/get.md)
* [post](/docs/location/post.md)

##### Role

Endpoints for getting and manipulating user roles
* [delete](/docs/role/delete.md)
* [get](/docs/role/get.md)
* [post](/docs/role/post.md)

##### User

Endpoints for getting user contact information
* [get](/docs/user/get.md)