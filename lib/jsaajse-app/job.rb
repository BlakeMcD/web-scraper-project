class JsaajseApp::Job 

    attr_accessor :job_title, :company_name, :location, :statement, :url, :job_details

    @@all = []
    @@locations = []
    @@city_array = []

    def initialize
        @@all << self    
    end

    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

    def self.locations
        @@locations
    end

    def self.locations_reset_all
        @@locations.clear
    end

    def self.city_array
        @@city_array
    end

    def self.city_array=(array)
        @@city_array = array
    end

    def self.city_array_reset_all
        @@city_array.clear
    end

end
