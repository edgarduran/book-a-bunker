FactoryGirl.define do
  factory :bunker do
    title
    description
    price 10
    status nil
    image "https://www.wpclipart.com/weapons/axe/Axe_red.svg"
  end

  sequence :title do |n|
    "Title#{n}"
  end

  sequence :description do |n|
    "Description#{n}"
  end

  factory :user do
    first_name
    last_name
    address "1510 Blake St"
    city "Denver"
    state "CO"
    zipcode "80202"
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

  # factory :category do
  #   title
  #
  #   factory :category_with_items do
  #     items { create_list(:item, 2) }
  #   end
  # end
  #
  # factory :order do
  #   items { create_list(:item, 2) }
  # end
end
