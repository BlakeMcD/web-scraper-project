class JsaajseApp::Job 

    attr_accessor :job_title, :company_name, :location, :statement, :url

    @@all = []

    @@locations = []

    def initialize
        @@all << self    
    end

    def self.all
        @@all
    end

    def self.locations
        @@locations
    end

    def self.reset_all
        @@all.clear
    end

    def self.clear_locations
        @@locations.clear
    end

end