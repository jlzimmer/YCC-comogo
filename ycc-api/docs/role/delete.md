# Delete Role

Delete a specific location

**URL** : `/api/role/:_id/`

**URL Parameters** : `_id=[string of length 24]` where `_id` is the ID of the role in the database.

**Method** : `DELETE`

**Auth required** : YES

**Role required** : `Super Admin`

**Data** : `{}`

## Success Response

**Condition** : If the role exists.

**Code** : `200 OK`

**Content** :

```json
{
  "message": "success"
}
```

## Error Responses

**Condition** : If there was no role to delete.

**Code** : `404 NOT FOUND`

**Content** :

```json
{
  "error": "Role not found"
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
