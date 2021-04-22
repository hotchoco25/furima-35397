# FurimaのER図

## usersテーブル

| Colum              | Type    | Option                    |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_kana          | string  | null: false               |
| first_kana         | string  | null: false               |
| birth              | date    | null: false               |

### Association

- has_many :items
- has_many :records

## itemsテーブル

| Colum       | Type       | Option                         |
| ----------- | ---------- | ------------------------------ |
| item_name   | string     | null: false                    |
| text        | text       | null: false                    |
| category_id | integer    | null: false                    |
| status_id   | integer    | null: false                    |
| pay_id      | integer    | null: false                    |
| area_id     | integer    | null: false                    |
| day_id      | integer    | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :record

## buysテーブル

| Colum        | Type       | Option                         |
| ------------ | ---------- | ------------------------------ |
| post_code    | string     | null: false                    |
| pref_id      | integer    | null: false                    |
| muni         | string     | null: false                    |
| add          | string     | null: false                    |
| buil         | string     |                                |
| tel          | string     | null: false                    |

### Association

- has_one :record

## recordsテーブル

| Colum        | Type       | Option                         |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| item         | references | null: false, foreign_key: true |
| buy          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :buy