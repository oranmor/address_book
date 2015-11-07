if Rails.env.development?
  10.times do
    FactoryGirl.create(:contact)
  end
end
