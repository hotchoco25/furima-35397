class Status < ActiveHash::Base
  self.data = [
    { id: 1, status_name: '---' },
    { id: 2, status_name: '新品、未使用' },
    { id: 3, status_name: '未使用に近い' },
    { id: 4, status_name: '目立った傷や汚れなし' },
    { id: 5, status_name: 'やや傷や汚れあり' },
    { id: 6, status_name: '傷や汚れあり' },
    { id: 7, status_name: '全体的に状態が悪い' }
  ]

  include ActiveHash::Associations
  has_many :items
end
