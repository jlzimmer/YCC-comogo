# Post Event

Create a new event

**URL** : `/api/event/`

**Method** : `POST`

**Auth required** : YES

**Role required** : `Admin`

**Data constraints**

```json
{
    "title": "[title of event]",
    "description": "[description of the event]",
    "image": "[binary buffer of an image for the event] *Optional*",
    "start": "[unix timestamp for start of event]",
    "end": "[unix timestamp for end of event]",
    "url": "[url for social media page of event] *Optional*",
    "hostUser": "[_id of the hosting user]",
    "category": "[_id of the category for the event]",
    "location": "[_id of the location for the event]"
}
```

**Data example**

```json
{
	  "title": "Test Event",
	  "description": "This is a test event",
	  "start": "1544443200",
	  "end": "1544446800",
	  "hostUser": "5bea196d648ec961bd73779e",
	  "category": "5bea30061698af62603438ab",
	  "location": "5bea441a501ee36328f1e734"
}
```

## Success Response

**Code** : `200 OK`
 
**Content example**
 
The event object with _id
```json
{
    "_id": "5bea4dbeb1b6de638a15c204",
    "title": "Test Event",
    "description": "This is a test event",
    "image": {},
    "start": "1970-01-18T21:00:43.200Z",
    "end": "1970-01-18T21:00:46.800Z",
    "posted": "2018-11-13T04:06:22.186Z",
    "hostUser": "5bea196d648ec961bd73779e",
    "category": "5bea30061698af62603438ab",
    "location": "5bea441a501ee36328f1e734"
}
```

## Error Responses

**Condition** : If a data constraint is not met.

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
