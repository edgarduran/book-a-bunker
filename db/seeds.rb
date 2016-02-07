class Seed
  def self.start
    seed = Seed.new
    # seed.generate_bunkers
    seed.generate_locations
    seed.generate_stores
  end

  def generate_locations
    locations = ["Atlanta", "Augusta", "Bismarck", "Charlotte", "Chicago",
                 "Dallas", "Denver", "Detroit", "Green Bay", "Kansas City",
                 "Los Angeles", "Memphis", "Miami", "New Orleans", "New York",
                 "Phoenix", "Portland", "Salt Lake City", "San Francisco", "Washington, D.C."]
    locations.each do |location|
      city = Location.create(city: location)
      puts "Created City: #{city.city}"
      generate_bunkers(city)
    end
  end

  def generate_stores
    20.times do |i|
      store = Store.create(name: Faker::Company.name,
                           description: Faker::Company.catch_phrase)
      puts "Created Store #{i}: #{store.name}"
      add_bunkers_to_store(store)
    end
  end

  def generate_bunkers(target)
    50.times do |i|
      bunker = Bunker.create(
        title: Faker::Lorem.word,
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        image: 'futuristic-bunker.jpg',
        bedrooms: Faker::Number.between(1, 5),
        bathrooms: Faker::Number.between(0, 3)
      )
      puts "Created Bunker #{i}: #{bunker.title}"
      target.bunkers << bunker
    end
  end

  def add_bunkers_to_store(store)
    3.times do |i|
      puts "Added Bunkers to Store #{store.id}"
      bunker = Bunker.offset(rand(Bunker.count)).first
      store.bunkers << bunker
    end
  end

  # def generate_users
  #   5.times do |i|
  #     User.create(name: Faker::Name.name, email: Faker::Internet.email)
  #     puts "Created user number #{i}"
  #   end
  # end

end

Seed.start
binding.pry
