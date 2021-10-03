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
        prompt_location_selection()

    end

    def list_jobs
        JsaajseApp::Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.job_title}"
        end
    end

    def unique_locations
        JsaajseApp::Job.all.each do |job| 
            unless JsaajseApp::Job.locations.include?(job.location.strip)
                JsaajseApp::Job.locations << job.location
            end  
        end
        JsaajseApp::Job.locations << "Across Australia"
        display_unique_locations(JsaajseApp::Job.locations)
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

        case JsaajseApp::Job.locations.sort[input-1]
            when "Adelaide"
                puts "you picked Adelaide"
            when "Brisbane"
                puts "you picked Brisbane"
            when "Melbourne"
                puts "you picked Melbourne"
            when "Perth"
                puts "you picked Perth"
            when "Sunshine Coast"
                puts "you picked Sunshine Coast"
            when "Sydney"
                puts "you picked Sydney"
            when "Across Australia"
                list_jobs_by_location(JsaajseApp::Job.locations.sort[input-1])
            else
                puts "Wrong input foo!"
        end
    end

    def list_jobs_by_location(city)
        puts "Junior Software Developer Jobs: #{city.upcase}"

        if city == "Across Australia" 
            
        else
            
        end
        JsaajseApp::Job.all.each.with_index(1) do |job, i|
            puts "#{i}. #{job.job_title}"

            puts job.statement

            puts job.url

            divider()
            divider()
        end
    end


end