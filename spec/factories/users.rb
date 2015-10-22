# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
		email { Faker::Internet.email }
		password 'secret'
		password_confirmation 'secret'
		admin false

		factory :admin do
			admin true
		end

		factory :invalid_user do
			password nil
		end
  end
end
