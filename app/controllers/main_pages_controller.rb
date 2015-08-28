class MainPagesController < ApplicationController
  autocomplete :city, :name_and_cc

  require 'open_weather'
  @team_page = false

  def add_to_user
    list = List.find(params[:list_id])
    items = list.items
    @list = list.dup
    @list.user_id = params[:user_id]
    @list.save
    items.each do |i|
      item = i.dup
      item.list_id = @list.id
      item.save
    end
    flash[:notice] = 'The official list is now added to your account!'
    redirect_to user_path(params[:user_id])
  end

  def home
    @html_title = "Traversal - Home"
  end

  def list_results
    @html_title = "Traversal - Results"

    @city = params[:city]
    @num_of_days = params[:duration]

    #@displayString = OpenWeather::Current.city(@city) Using openweather gem

    def find_by_city(city) #returns as a JSON
      #use HTTP to call random APIs using a query string
      HTTParty.get('http://api.openweathermap.org/data/2.5/weather', :query => {:q => city, :units => 'metric'})
    end

    def find_by_city_forecast(city, days)
      HTTParty.get('http://api.openweathermap.org/data/2.5/forecast', :query => {:q => city, :units => 'metric', :cnt => days})
    end

    def get_lat_long_by_city_name(city)
      Geocoder.coordinates(city)
    end

    #  puts find_by_city(@city).body #(shows up in the Rails server)
    weather_info = JSON.parse(find_by_city(@city).body)
    @displayString = weather_info["main"]["temp"].to_s + "°C"
    @displayString2 = weather_info["main"]["temp_min"].to_s + "°C"
    @displayString3 = weather_info["main"]["temp_max"].to_s + "°C"
    @weatherIcon = weather_info["weather"]
    @weatherIcon2 = @weatherIcon[0]["icon"]

    weather_forecast = JSON.parse(find_by_city_forecast(@city, 14).body)
    #puts find_by_city_forecast(@city,14).body
    #@displayForecast =  weather_forcast
    @displayForecastHash = weather_forecast["list"] #+ "°C"
    @displayForecastArray = []
    @displayForecastHash.each do |w|
      @displayForecastArray.push w["main"]["temp"]
    end

    @displayForecastArray2 = []
    @displayForecastHash.each do |v|
      @displayForecastArray2.push v["weather"][0]["icon"]
    end

    @lat_long = get_lat_long_by_city_name(@city)

    currentTemp = weather_info["main"]["temp"].to_f
    if currentTemp > '25.4'.to_f
      @season = 'Summer'.to_s
    elsif currentTemp < '14.4'.to_f
      @season = 'Winter'.to_s
    elsif currentTemp > '14.4'.to_f and currentTemp < '18.2'.to_f
      @season = 'Spring'.to_s
    else
      @season = 'Autumn'.to_s
    end

    #@season = @season.downcase
    @season_wrapper = "%"+@season+"%"

    @admin_user_id =  User.find_by( email: "admin@traversal.com").id
    @itemList = List.find_by('user_id = ? AND name LIKE ?', @admin_user_id, @season_wrapper).items.pluck(:name)
    
    @season_list = List.find_by('user_id = ? AND name LIKE ?', @admin_user_id, @season_wrapper)

    def find_image_by_city(city) #returns as a JSON
      #use HTTP to call random APIs using a query string
      HTTParty.get('https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=df3839f752aa839b3ea7e167b6f7394b&safe_search=1&per_page=10&page=1&format=json&nojsoncallback=1&tag_mode=AND', :query => {:tags => "#{city}&landscape"})
    end
    cityImage = JSON.parse(find_image_by_city(@city).body)
    @id = cityImage["photos"]["photo"].first["id"]
    @farmId = cityImage["photos"]["photo"].first["farm"]
    @secretId = cityImage["photos"]["photo"].first["secret"]
    @serverId = cityImage["photos"]["photo"].first["server"]

    @id2 = cityImage["photos"]["photo"].second["id"]
    @farmId2 = cityImage["photos"]["photo"].second["farm"]
    @secretId2 = cityImage["photos"]["photo"].second["secret"]
    @serverId2 = cityImage["photos"]["photo"].second["server"]

    @id3 = cityImage["photos"]["photo"].third["id"]
    @farmId3 = cityImage["photos"]["photo"].third["farm"]
    @secretId3 = cityImage["photos"]["photo"].third["secret"]
    @serverId3 = cityImage["photos"]["photo"].third["server"]

    @id4 = cityImage["photos"]["photo"].fourth["id"]
    @farmId4 = cityImage["photos"]["photo"].fourth["farm"]
    @secretId4 = cityImage["photos"]["photo"].fourth["secret"]
    @serverId4 = cityImage["photos"]["photo"].fourth["server"]

    @id5 = cityImage["photos"]["photo"].fifth["id"]
    @farmId5 = cityImage["photos"]["photo"].fifth["farm"]
    @secretId5 = cityImage["photos"]["photo"].fifth["secret"]
    @serverId5 = cityImage["photos"]["photo"].fifth["server"]


  end

  def about_us
    @html_title = "Traversal Team"
    @team_page = true
  end

  def contact_us
    @html_title = "Traversal Contact Us"
    @team_page = true
  end






end
