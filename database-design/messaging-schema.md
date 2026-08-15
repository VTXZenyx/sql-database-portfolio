# Messaging Database Design

This example shows how I normalised a flat messaging dataset into a relational database.

## Problem

The original flat structure repeated user names, group names and identifiers across many message rows. That can create update anomalies because the same fact may need to be changed in several places.

## Final 3NF Structure

```mermaid
erDiagram
    GROUP_ENTITY {
        TEXT group_id PK
        TEXT group_name
    }

    CHAT {
        TEXT chat_id PK
        TEXT group_id FK
        TEXT chat_type
    }

    USER_ENTITY {
        TEXT sender_phone PK
        TEXT sender_name
    }

    RECEIVER {
        TEXT receiver_id PK
        TEXT receiver_name
    }

    MESSAGE {
        TEXT chat_id PK, FK
        TEXT message_time PK
        TEXT receiver_id FK
        TEXT sender_phone FK
        TEXT message_text
        TEXT media_type
        TEXT media_name
    }

    GROUP_MEMBER {
        TEXT group_id PK, FK
        TEXT sender_phone PK, FK
        TEXT join_date
    }

    GROUP_ENTITY ||--o{ CHAT : contains
    CHAT ||--o{ MESSAGE : contains
    USER_ENTITY ||--o{ MESSAGE : sends
    RECEIVER ||--o{ MESSAGE : receives
    GROUP_ENTITY ||--o{ GROUP_MEMBER : has
    USER_ENTITY ||--o{ GROUP_MEMBER : joins
```

## Key Design Decisions

### Message primary key
`(chat_id, message_time)`

### Group data
Group names are stored once rather than repeated in every message.

### User data
User information is separated from message data so a user name can be updated in one place.

### Group membership
`Group_Member` resolves the many-to-many relationship between users and groups.

## SQL View

The database also includes a view called `v_studygroup_media`, which combines message, chat, group and user information to return media messages from the `StudyGroup`.
