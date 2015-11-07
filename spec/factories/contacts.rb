FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    emails { [Faker::Internet.email(first_name), Faker::Internet.email(last_name)] }
    phones { [Faker::PhoneNumber.cell_phone, Faker::PhoneNumber.cell_phone] }
  end
end
