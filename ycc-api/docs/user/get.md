# Get User

Get a specific user via Id, or get the current user associated with the token

**URL** : `/api/user/:_id/`

**URL Parameters** : `_id=[string of length 24]` where `_id` is the ID of the role in the database. *Optional*

**Method** : `GET`

**Auth required** : YES

**Role required** : `User`

**Data**: `{}`

## Success Response

**Condition** : _id is supplied and the user exists
 
**Code** : `200 OK`
 
**Content example**
 
 A single user object
```json
{
    "firstName": "John",
    "lastName": "Doe",
    "phoneNumber": "3334561234",
    "email": "johndoe@test.com"
}
```

### Or

**Condition** : _id is not supplied
 
**Code** : `200 OK`
 
**Content example**
 
The current user's object, with attendingEvents and hostingEvents
```json
{
    "attendingEvents": [
        "5bea4610eb64c0633ed5f778",
        "5bea4628eb64c0633ed5f77c"
    ],
    "hostingEvents": [
        "5bea4610eb64c0633ed5f778",
        "5bea4628eb64c0633ed5f77c"
    ],
    "_id": "5bea196d648ec961bd73779e",
    "email": "nathan.ortbals@gmail.com",
    "firstName": "Nathan",
    "lastName": "Ortbals",
    "phoneNumber": "5733558257",
    "role": "5bea197c648ec961bd7377a3"
    "__v": 9
}
```

## Error Responses

**Condition** : If `_id` is supplied and there is no user with specified `_id`

**Code** : `404 NOT FOUND`

**Content** : 
```json
{
  "error": "User not found"
}
```

### Or

**Condition** : User does not have required role.

**Code** : `403 FORBIDDEN`

**Content** :

```json
{
  "error": "Unauthorized, must be user role"
}
```

### Or

**Condition** : Token not supplied

**Code** : `403 FORBIDDEN`

**Content** :

```json
{
  "error": "No auth token"
}
```

### Or

**Condition** : Token is invalid

**Code** : `403 FORBIDDEN`

**Content** :

```json
{
  "error": "invalid token"
}
```
