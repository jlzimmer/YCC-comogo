# Post Role

Create a new role

**URL** : `/api/role/`

**Method** : `POST`

**Auth required** : YES

**Role required** : `Super Admin`

**Data constraints**

```json
{
	"title": "[Title of the role]"
}
```

**Data example**

```json
{
	"title": "SuperAdmin"
}
```

## Success Response

**Condition** : Data satisfies constraints
 
**Code** : `200 OK`
 
**Content example**
 
The role object with _id and version number
```json
{
    "users": [],
    "_id": "5beb1e9eed646d0538c4f589",
    "title": "SuperAdmin",
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
