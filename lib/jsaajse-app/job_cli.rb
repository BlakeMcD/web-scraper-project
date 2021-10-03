class JsaajseApp::JobCLI 

    def initialize
        JsaajseApp::Scraper.new.make_jobs
    end

    def start
        puts "Welcome to my CLI App"    
    end

end