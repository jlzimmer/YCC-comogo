# Validate Email Address

For validating user email accounts via email link.

**URL** : `/api/auth/validate/:key`

**URL Parameters** : `key=[string]` where `key` is the unique string sent to the user's email

**Method** : `GET`

**Auth required** : NO

**Permissions required** : None

**Data constraints** : `{}`

## Success Response

**Code** : `200 OK`

**Content example**

```json
{
    "message": "success"
}
```

## Error Response

**Condition** : If key is not found.

**Code** : `400 BAD REQUEST`

**Content** :

```json
{
    "error": "Key not found"
}
```
