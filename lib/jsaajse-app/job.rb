class JsaajseApp::Job 

    attr_accessor :job_title, :company_name, :location, :statement, :url

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

    def self.clear_locations
        @@locations.clear
    end

    def self.city_array
        @@city_array
    end

    def self.city_array_reset_all
        @@city_array.clear
    end

end

JsaajseApp::Job.clear_locations