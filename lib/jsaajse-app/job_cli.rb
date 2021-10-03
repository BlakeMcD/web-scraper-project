class JsaajseApp::JobCLI 

    def initialize
        JsaajseApp::Scraper.new.make_jobs
    end

    def start
        system("clear")
        puts "Welcome to JSAAJSE - An app that searches seek.com.au for Australian junior software engineer roles." 
        puts ""
        new_line()
        divider()
        new_line()
        unique_locations() 
    end

    def list_jobs
        JsaajseApp::Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.job_title}"
        end
    end

    def unique_locations
        locations = []
        JsaajseApp::Job.all.each do |job| 
            unless locations.include?(job.location.strip)
                locations << job.location
            end  
        end
        locations << "Wherever"
        display_unique_locations(locations)
    end

    def display_unique_locations(array)
        array.sort.each.with_index(1) do |element, index|
            puts "#{index}: #{element}"
        end 
    end

    #Formatting functions 
    def new_line
        puts ""
    end

    def divider
        puts "-------------------"
    end

    #prompt user
    def prompt_location_selection
        divider()
        puts "select the city you would like to search for:"

        input = gets.strip.to_i
    end

end