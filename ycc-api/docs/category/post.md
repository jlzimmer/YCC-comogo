# Post Category

Create a new category

**URL** : `/api/category/`

**Method** : `POST`

**Auth required** : YES

**Role required** : `Admin`

**Data constraints**

```json
{
  "title": "[title of category]"
}
```

**Data example**

```json
{
  "title": "athletics"
}
```

## Success Response

**Condition** : Title is supplied and unique.
 
**Code** : `200 OK`
 
**Content example**
 
The category object with _id and version number
```json
{
    "events": [],
    "_id": "5bea30061698af62603438ab",
    "title": "athletics",
    "__v": 0
}
```

## Error Responses

**Condition** : Title is supplied but it is not unique

**Code** : `404 NOT FOUND`

**Content** : 
```json
{
  "error": "Category title already exists",
}
```

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
