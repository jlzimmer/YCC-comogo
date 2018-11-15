# Register

Used to register a new user on the network.

**URL** : `/api/auth/register`

**Method** : `POST`

**Auth required** : NO

**Data constraints**

```json
{
  "email": "[valid email address]",
  "firstName": "[string minmum length 2, maximum 30]",
  "lastName": "[string minmum length 2, maximum 30]",
  "password": "[string minmum length 6, maximum 20]",
  "phoneNumber": "[string of 10 digits, no dashes]"
}
```

**Data example**

```json
{
  "email": "johndoe@test.com",
  "firstName": "John",
  "lastName": "Doe",
  "password": "abcd1234",
  "phoneNumber": "3334561234"
}
```

## Success Response

**Code** : `200 OK`

**Content example**

```json
{
    "_id": "5bea1fc7598c3b621be88765",
    "firstName": "John",
    "lastName": "Doe",
    "phoneNumber": "3334561234",
    "email": "johndoe@test.com"
}
```

## Error Response

**Condition** : If a data constraint is not met.

**Code** : `400 BAD REQUEST`

**Content** :

```json
{
    "error": "[error message]"
}
```

