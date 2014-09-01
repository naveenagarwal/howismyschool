# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    description "MyText"
    comentator nil
    comment_for nil
  end
end
