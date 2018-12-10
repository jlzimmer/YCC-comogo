# Get Location(s)

Get a specific location via Id, or get all locations.

**URL** : `/api/location/:_id/`

**URL Parameters** : `_id=[string of length 24]` where `_id` is the ID of the category in the database. *Optional*

**Method** : `GET`

**Auth required** : YES

**Role required** : `User`

**Data**: `{}`

## Success Response

**Condition** : _id is supplied and the location exists
 
**Code** : `200 OK`
 
**Content example**
 
 A list with a single location
```json
[
    {
        "events": [],
        "_id": "5bea441a501ee36328f1e734",
        "title": "Hickman High School",
        "addressLine1": "1104 N Providence Rd",
        "addressLine3": "Columbia, MO 65203",
        "__v": 9
    }
]
```

### Or

**Condition** : _id is not supplied
 
**Code** : `200 OK`
 
**Content example**
 
A list of all locations
```json
[
    {
        "events": [],
        "_id": "5bea441a501ee36328f1e734",
        "title": "Hickman High School",
        "addressLine1": "1104 N Providence Rd",
        "addressLine3": "Columbia, MO 65203",
        "__v": 9
    },
    {
        "events": [],
        "_id": "5beb13bb8d99fd048a675abb",
        "title": "Rock Bridge High School",
        "addressLine1": "7198, 4303 S Providence Rd",
        "addressLine3": "Columbia, MO 65203",
        "__v": 0
    }
]
```

## Error Responses

**Condition** : If `_id` is supplied and there is no location with specified `_id`

**Code** : `404 NOT FOUND`

**Content** : 
```json
{
  "error": "Location not found"
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
