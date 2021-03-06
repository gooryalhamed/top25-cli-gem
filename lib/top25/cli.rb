class Top25::Cli

  def home
      puts "Search for the best in the world, choose one of the follwing numbers"
      puts "1. Hotels\n2. Restaurants\n3. Beaches\n4. for exit"
      take_input
  end

  def take_input
    input =""
    input = gets.strip
    search(input)
  end

  def search(s)
    if s == "1"
      puts "Top 25 Hotels"
      puts "=================".colorize(:blue)
      run("Hotels")
      home
    elsif s == "2"
      puts "Top 25 Restaurants"
      puts "=================".colorize(:blue)
      run("Restaurants")
      home
    elsif s == "3"
      puts "Top 25 Beaches"
      puts "=================".colorize(:blue)
      run("Beaches")
      home
    elsif !(s.to_i.between?(1, 4))
        puts "sorry, you only can search hotels,restaurants and beaches"
        home
    elsif s == "4"
      puts "Good bye ^ _ ^"
    end
end

  def run(place)
    make_places(place)
    #add_attributes
    display_places
  end

  def make_places(name)
    scraper = Top25::Scraper.new
    arrofplaces = scraper.scrap_index_page(name)
    Top25::Place.create_from_collection(arrofplaces)
  end

  def display_places
    Top25::Place.all.each do |pl|
      puts "#{pl.num}. #{pl.name}-based in: #{pl.location}"
      puts "Website: #{pl.url}"
      puts "-------------------------------------".colorize(:green)
      end
  end

end
=begin
    def add_attributes
      scraper = Top25::Scraper.new
      Top25::Place.all.each do |place|
        h = scraper.scrap_show_page(place.url)
        place.add_attr(h)
        end
    end
=end
