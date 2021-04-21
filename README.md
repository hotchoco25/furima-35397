# FurimaのER図

## usersテーブル

| Colum      | Type    | Option      |
| ---------- | ------- | ----------- |
| nickname   | string  | null: false |
| mail       | string  | null: false |
| password   | string  | null: false |
| last name  | string  | null: false |
| first name | string  | null: false |
| last kana  | string  | null: false |
| first kana | string  | null: false |
| born year  | integer | null: false |
| born month | integer | null: false |
| born day   | integer | null: false |

### Association

- has_many items
- has_many buys

## itemsテーブル

| Colum     | Type       | Option                         |
| --------- | ---------- | ------------------------------ |
| item name | string     | null: false                    |
| text      | text       | null: false                    |
| category  | string     | null: false                    |
| status    | string     | null: false                    |
| pay       | string     | null: false                    |
| area      | string     | null: false                    |
| days      | integer    | null: false                    |
| price     | integer    | null: false                    |
| user      | references | null: false, foreign_key: true |

### Association

- belongs_to user
- has_one buy

## buysテーブル

| Colum        | Type       | Option                         |
| ------------ | ---------- | ------------------------------ |
| card info    | string     | null: false                    |
| exdate month | integer    | null: false                    |
| exdate year  | integer    | null: false                    |
| secur code   | integer    | null: false                    |
| post code    | string     | null: false                    |
| pref         | string     | null: false                    |
| muni         | string     | null: false                    |
| add          | string     | null: false                    |
| buil         | string     | null: false                    |
| tel num      | string     | null: false                    |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |

### Association

- belongs_to user
- belongs_to item