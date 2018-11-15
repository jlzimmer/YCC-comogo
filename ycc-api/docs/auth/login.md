# Login

Used to collect a Token for a User.

**URL** : `/api/auth/login`

**Method** : `POST`

**Auth required** : NO

**Data constraints**

```json
{
    "email": "[valid email address]",
    "password": "[password in plain text]"
}
```

**Data example**

```json
{
    "username": "johndoe@example.com",
    "password": "abcd1234"
}
```

## Success Response

**Code** : `200 OK`

**Content example**

```json
{
    "token": "JWT eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdHRlbmRpbmdFdmVudHMiOltdLCJob3N0aW5nRXZlbnRzIjpbXSwiX2lkIjoiNWJlYTE5NmQ2NDhlYzk2MWJkNzM3NzllIiwiZW1haWwiOiJuYXRoYW4ub3J0YmFsc0BnbWFpbC5jb20iLCJmaXJzdE5hbWUiOiJOYXRoYW4iLCJsYXN0TmFtZSI6Ik9ydGJhbHMiLCJwYXNzd29yZCI6IiQyYiQxMCRTMjVlS0gwT21SdUw3UXA5bnIudldleG5nMGhpV3JPckdNZS9pOEQySUtpZnZ6c0h4b3NCRyIsInBob25lTnVtYmVyIjoiNTczMzU1ODI1NyIsInJvbGUiOiI1YmVhMTk3YzY0OGVjOTYxYmQ3Mzc3YTIiLCJ2YWxpZGF0aW9uS2V5IjoiNWJlYTE5NmQ2NDhlYzk2MWJkNzM3N2ExIiwiX192IjowLCJpYXQiOjE1NDIwNjg2MjZ9.g1iwqJvmcl_npr7XC88htUy03tGj8Uue7_BF5O6O55U"
}
```

## Error Response

**Condition** : If 'email' is not found.

**Code** : `400 BAD REQUEST`

**Content** :

```json
{
    "error": "Email not found"
}
```

**Condition** : If 'email' and 'password' combination is wrong.

**Code** : `400 BAD REQUEST`

**Content** :

```json
{
    "error": "Password incorrect"
}
```
