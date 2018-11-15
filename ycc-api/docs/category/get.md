# Get Category(s)

Get a specific category via Id, or get all categories.

**URL** : `/api/category/:_id/`

**URL Parameters** : `_id=[string of length 24]` where `_id` is the ID of the category in the database. *Optional*

**Method** : `GET`

**Auth required** : YES

**Role required** : `User`

**Data**: `{}`

## Success Response

**Condition** : _id is supplied and the category exists
 
**Code** : `200 OK`
 
**Content example**
 
 A list with a single category
```json
[
    {
        "events": [],
        "_id": "5bea30061698af62603438ab",
        "title": "athletics",
        "__v": 0
    }
]
```

### Or

**Condition** : _id is not supplied
 
**Code** : `200 OK`
 
**Content example**
 
A list of all categories
```json
[
    {
        "events": [],
        "_id": "5bea30061698af62603438ab",
        "title": "athletics",
        "__v": 0
    },
    {
        "events": [],
        "_id": "5bea34422dcb7c62b2e3da97",
        "title": "speech & debate",
        "__v": 0
    }
]
```

## Error Responses

**Condition** : If `_id` is supplied and there is no category with specified `_id`

**Code** : `404 NOT FOUND`

**Content** : 
```json
{
  "error": "Category not found"
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
