# Post Location

Create a new location

**URL** : `/api/location/`

**Method** : `POST`

**Auth required** : YES

**Role required** : `Admin`

**Data constraints**

```json
{
    "title": "[title of the location]",
    "addressLine1": "[First address line]",
    "addressLine2": "[Second address line] *optional*",
    "addressLine3": "[Third address line] *optional*"
}
```

**Data example**

```json
{
	"title": "Rock Bridge Highschool",
	"addressLine1": "7198, 4303 S Providence Rd",
	"addressLine3": "Columbia, MO 65203"
}
```

## Success Response

**Condition** : Data satisfies constraints
 
**Code** : `200 OK`
 
**Content example**
 
The location object with _id and version number
```json
{
    "events": [],
    "_id": "5beb13bb8d99fd048a675abb",
    "title": "Rock Bridge Highschool",
    "addressLine1": "7198, 4303 S Providence Rd",
    "addressLine3": "Columbia, MO 65203",
    "__v": 0
}
```

## Error Responses

**Condition** : If data constraint is not met.

**Code** : `400 BAD REQUEST`

**Content** :

```json
{
    "error": "[error message]"
}
```

### Or

**Condition** : User does not have required role.

**Code** : `403 FORBIDDEN`

**Content** :

```json
{
  "error": "Unauthorized, must be admin role"
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
