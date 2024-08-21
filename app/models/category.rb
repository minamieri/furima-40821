# class Genre < ActiveHash::Base
class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: 'レディース' },
    { id: 3, name: 'メンズ' },
    { id: 4, name: 'ベビー・キッズ' },
    { id: 5, name: 'インテリア・住まい・小物' },
    { id: 6, name: '家電・スマホ・カメラ' },
    { id: 7, name: 'スポーツ・レジャー' },
    { id: 8, name: 'ハンドメイド' },
    { id: 9, name: '初音ミク' },
    { id: 10, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :products
end
