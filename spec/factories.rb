FactoryBot.define do
  factory :comment do
    
  end

    factory :user do
        sequence :email do |n|
            "dummyEmail#{n}@gmail.com" 
        end
        password { "secretPassword" }
        password_confirmation { "secretPassword" }
    end

    factory :bit do
        message { "hello" }
        pics { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'sample.jpg').to_s, 'image/jpg') }
        association :user
    end
end