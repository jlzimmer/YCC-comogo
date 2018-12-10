# Get Event

Get a specific event by id

**URL** : `/api/category/:_id:title:start:end:category:location/`

**URL Parameters** : 

`_id=[string of length 24]` where `_id` is the ID of the event in the database.

**Method** : `GET`

**Auth required** : YES

**Role required** : `User`

**Data**: `{}`

## Success Response

**Condition** : _id is supplied and the event exists
 
**Code** : `200 OK`
 
**Content example**
 
 A single event object
```json
{
    "attendingUsers": [],
    "_id": "5bea4610eb64c0633ed5f778",
    "title": "Test Event",
    "description": "This is a test event",
    "start": "1970-01-18T21:00:43.200Z",
    "end": "1970-01-18T21:00:46.800Z",
    "posted": "2018-11-13T03:33:36.685Z",
    "hostUser": "5bea196d648ec961bd73779e",
    "category": "5bea30061698af62603438ab",
    "location": "5bea441a501ee36328f1e734",
    "__v": 0
}
```

## Error Responses

**Condition** : If `_id` is supplied and there is no event with specified `_id`

**Code** : `404 NOT FOUND`

**Content** : 
```json
{
  "error": "Event not found"
}
```

### Or

**Condition** : `_id` is not supplied in the url parameters.

**Code** : `400 BAD REQUEST`

**Content** :

```json
{
    "error": "\"_id\" is required"
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
