# Delete Category

Delete a specific category

**URL** : `/api/category/:_id/`

**URL Parameters** : `_id=[string of length 24]` where `_id` is the ID of the category in the database.

**Method** : `DELETE`

**Auth required** : YES

**Role required** : `Admin`

**Data** : `{}`

## Success Response

**Condition** : If the Category exists.

**Code** : `200 OK`

**Content** :

```json
{
  "message": "success"
}
```

## Error Responses

**Condition** : If there was no Category to delete.

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
