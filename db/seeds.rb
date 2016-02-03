class Seed
  def self.start
    seed = Seed.new
    seed.generate_bunkers
    seed.generate_locations
  end

  def generate_locations
    20.times do |i|
      location = Location.create(city: Faker::Address.city)
      puts "Created City #{i}: #{location.city}"
      add_bunkers(location)
    end
  end

  def generate_bunkers
    60.times do |i|
      bunker = Bunker.create(
        title: Faker::Lorem.word,
        description: Faker::Lorem.paragraph,
        price: Faker::Commerce.price,
        image: Faker::Avatar.image,
        bedrooms: Faker::Number.between(1, 5),
        bathrooms: Faker::Number.between(0, 3)
      )
      puts "Created Bunker #{i}: #{bunker.title}"
    end
  end

  def add_bunkers(location)
    3.times do |i|
      puts "Added Bunkers to Location #{location.id}"
      bunker = Bunker.offset(rand(Bunker.count)).first
      location.bunkers << bunker
    end
  end

  # def generate_stores
  #
  # end

  # def generate_users
  #   5.times do |i|
  #     User.create(name: Faker::Name.name, email: Faker::Internet.email)
  #     puts "Created user number #{i}"
  #   end
  # end

end

Seed.start
