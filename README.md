# FurimaのER図

## usersテーブル

| Colum              | Type    | Option                    |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last name          | string  | null: false               |
| first name         | string  | null: false               |
| last kana          | string  | null: false               |
| first kana         | string  | null: false               |
| birth              | date    | null: false               |

### Association

- has_many items
- has_many buys

## itemsテーブル

| Colum       | Type       | Option                         |
| ----------- | ---------- | ------------------------------ |
| item name   | string     | null: false                    |
| text        | text       | null: false                    |
| category_id | integer    | null: false                    |
| status_id   | integer    | null: false                    |
| pay_id      | integer    | null: false                    |
| area_id     | integer    | null: false                    |
| day_id      | integer    | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to user
- has_one buy

## buysテーブル

| Colum        | Type       | Option                         |
| ------------ | ---------- | ------------------------------ |
| post code    | string     | null: false                    |
| pref_id      | integer    | null: false                    |
| muni         | string     | null: false                    |
| add          | string     | null: false                    |
| buil         | string     |                                |
| tel num      | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to user
- belongs_to item