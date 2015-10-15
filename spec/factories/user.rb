FactoryGirl.define do
 factory :user do
   email    'mail@example.com'
   password '123456789'
   password_confirmation '123456789'
 end

 factory :user2, class: User do
   email    'example@example2.com'
   password '123456789'
   password_confirmation '123456789'
 end
end
