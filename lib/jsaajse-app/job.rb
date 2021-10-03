class JsaajseApp::Job 

    attr_accessor :job_title, :company_name, :location, :statement, :url

    @@all = []

    def initialize
        @@all << self    
    end

    def self.all
        @@all
    end

    def self.reset_all
        @@all.clear
    end

end