Fabricator(:business) do
  name { Faker::Name.name }
  description { Faker::Lorem.sentence }
  category_id { [*1..5].sample }
end