# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :schedule do
    title "MyString"
    creator nil
    school_branch nil
    event_for ""
    start_time "2014-07-16 12:33:42"
    end_time "2014-07-16 12:33:42"
  end
end
