# The schema

## Users (toooodo)

- email (required, unique)
- password (salted) (v2)
- profile picture
- ties[]

## Tie

- name
- last conversation (v1)
- accounts[] (v2)

## Tag

- name

## TieTag

- tie_id
- tag_id

## ServiceAccount (v2)

- service name
- username/email
- profile picture (optional)
- last conversation