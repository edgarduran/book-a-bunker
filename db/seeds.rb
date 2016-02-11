class Seed

  attr_accessor :counter

  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_stores
    seed.generate_locations
    seed.generate_store_admin_andrew
    seed.generate_registered_users
    seed.generate_registered_user_josh
    seed.generate_platform_admin_jorge
  end

  def generate_roles
    Role.create(name: "platform_admin")
    Role.create(name: "store_admin")
    Role.create(name: "registered_user")
  end

  def generate_locations
    locations = ["Atlanta", "Augusta", "Bismarck", "Charlotte", "Chicago",
                 "Dallas", "Denver", "Detroit", "Green Bay", "Kansas City",
                 "Los Angeles", "Memphis", "Miami", "New Orleans", "New York",
                 "Phoenix", "Portland", "Salt Lake City", "San Francisco", "Washington,D.C."]
    locations.each do |location|
      city = Location.create(city: location)
      puts "Created City: #{city.city}"
      generate_bunkers(city)
    end
  end

  def generate_stores
    19.times do |i|
      store = Store.create(name: Faker::Company.name,
                           description: Faker::Company.catch_phrase,
                           approved: true)
      user = User.create(first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         email: Faker::Internet.email,
                         password: "password")
      puts "Created Store: #{store.name}"
      store.users << user
      user.roles << Role.find_by(name: "store_admin")
    end
  end

  def generate_store_admin_andrew
    store = Store.create(name: "Andrew's Apples",
                         description: "The best apples this side of the divide.",
                         approved: true)
    andrew = User.create(first_name: "Andrew",
                         last_name: "Carmer",
                         email: "andrew@turing.io",
                         password: "password")
    puts "Created Store Admin Andrew!"
    store.users << andrew
    andrew.roles << Role.find_by(name: "store_admin")

    50.times do |i|
      bunker = Bunker.create(
        title: "Apple Bunker ##{i}",
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        image: "andrews-apple-bunker.jpg",
        bedrooms: Faker::Number.between(1, 5),
        bathrooms: Faker::Number.between(0, 3)
      )
      puts "Created Bunker #{i}: #{bunker.title}"
      store = Store.find_by(name: "Andrew's Apples")
      location = Location.find_by(city: "Denver")
      store.bunkers << bunker
      location.bunkers << bunker
    end
  end

  def generate_registered_users
    99.times do |i|
      user = User.create(first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         email: Faker::Internet.email,
                         password: "password")
      puts "Created User: #{user.first_name} #{user.last_name}"
      user.roles << Role.find_by(name: "registered_user")
      10.times do |x|
        store = Store.find(x+1)
        bunker = store.bunkers.find(x+1)
        current = user.orders.create
        current.bunkers << bunker
        store.orders << current
        puts "Order ##{x} for user."
      end
    end
  end

  def generate_registered_user_josh
    josh = User.create(first_name: "Josh",
                       last_name: "Mejia",
                       email: "josh@turing.io",
                       password: "password")
    puts "Created Registered User Josh!"
    josh.roles << Role.find_by(name: "registered_user")
    10.times do |x|
      store = Store.find(x+1)
      bunker = store.bunkers.find(x+1)
      current = josh.orders.create
      current.bunkers << bunker
      store.orders << current
      puts "Order ##{x} for user."
    end
  end

  def generate_platform_admin_jorge
    jorge = User.create(first_name: "Jorge",
                       last_name: "Tellez",
                       email: "jorge@turing.io",
                       password: "password")
    puts "Created Platform Admin Jorge!"
    jorge.roles << Role.find_by(name: "platform_admin")
  end

  def generate_bunkers(target)
    images = ["abandoned-beach-bunker.jpg", "airy-bunker.jpg", "bond-bunker.jpg", "futuristic-bunker.jpg",
              "gun-bunker.jpg", "italian-ocean-bunker.jpg", "serene-bunker.jpg", "ww1-park-bunker.jpg"]
    @counter = 1
    50.times do |i|
      bunker = Bunker.create(
        title: "Bunker ##{i} #{target.city}",
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        image: images[rand(images.length)],
        bedrooms: Faker::Number.between(1, 5),
        bathrooms: Faker::Number.between(0, 3)
      )
      puts "Created Bunker #{i}: #{bunker.title}"
      store = Store.find(counter)
      store.bunkers << bunker
      target.bunkers << bunker
      @counter += 1
      if @counter == 20
        @counter = 1
      end
    end
  end

end

Seed.start
