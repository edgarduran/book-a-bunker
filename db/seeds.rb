class Seed

  attr_accessor :counter

  def self.start
    seed = Seed.new
    seed.generate_roles
    seed.generate_stores
    seed.generate_locations
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
    20.times do |i|
      store = Store.create(name: Faker::Company.name,
                           description: Faker::Company.catch_phrase,
                           approved: true)
      user = User.create(first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         email: Faker::Internet.email,
                         password: "password",)
      puts "Created Store: #{store.name}"
      store.users << user
      user.roles << Role.find_by(name: "store_admin")
    end
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
      if @counter == 21
        @counter = 1
      end
    end
  end

end

Seed.start
