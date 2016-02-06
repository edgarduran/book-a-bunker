FactoryGirl.define do

  factory :bunker do
    title
    description
    price 10
    status nil
    image "https://upload.wikimedia.org/wikipedia/commons/0/01/Albania_bunker_2.jpg"
  end

  sequence :title do |n|
    "Title #{n}"
  end

  sequence :description do |n|
    "Description #{n}"
  end

  factory :store do
    name
    description

    factory :store_with_bunkers do
      bunkers { create_list(:bunker, 2) }
    end
  end

  sequence :name do |n|
    "Name #{n}"
  end

  factory :user do
    first_name
    last_name
    email
    password "password"
    password_confirmation "password"

    factory :user_with_orders do
      orders { create_list(:order, 2) }
    end

    factory :user_with_order do
      orders { create_list(:order, 1) }
    end
  end

  sequence :first_name do |n|
    "First name #{n}"
  end

  sequence :last_name do |n|
    "Last name #{n}"
  end

  sequence :email do |n|
    "email#{n}@zombiez.com"
  end

  factory :location do
    city

    factory :location_with_bunker do
      bunkers { create_list(:bunker, 1) }
    end

    factory :location_with_bunkers do
      bunkers { create_list(:bunker, 2) }
    end
  end

  sequence :city do |n|
    "City #{n}"
  end

  factory :order do
    bunkers { create_list(:bunker, 2) }
  end
end
