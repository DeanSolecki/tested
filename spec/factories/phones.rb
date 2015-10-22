# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phone do
		association :contact
    phone { Faker::PhoneNumber.phone_number }
		phone_type 'default'

		factory :home_phone do
			phone_type 'home'
		end

		factory :work_phone do
			phone_type 'work'
		end

		factory :mobile_phone do
			phone_type 'mobile'
		end

		factory :invalid_phone do
			phone nil
		end
  end
end
