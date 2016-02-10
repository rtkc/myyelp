Fabricator(:business) do
  name { Faker::Name.name }
  description { Faker::Lorem.sentence }
end