class Day < ActiveHash::Base
  self.data = [
    { id: 1, day_name: '---' },
    { id: 2, day_name: '1~2日で発送' },
    { id: 3, day_name: '2~3日で発送' },
    { id: 4, day_name: '4~7日で発送' }
  ]

  include ActiveHash::Associations
  has_many :items
end