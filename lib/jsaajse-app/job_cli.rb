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

    def contains_letter_or_symbol(str)
        str.match(/[\D]/)
    end

    #prompt user
    def prompt_location_selection

        divider()
        puts "select the city you would like to search for:"


        input = gets.strip.to_i

        if input == 0 || input > JsaajseApp::Job.locations.length 
            puts "you done messed up!"
            JsaajseApp::Job.clear_locations
            unique_locations() 
            prompt_location_selection()
        # elsif contains_letter_or_symbol(input)
        #     puts "you put a symbol in here, you peasant!"
        else
            list_jobs_by_location(JsaajseApp::Job.locations.sort[input-1])
        end

        # if contains_letter_or_symbol(input)
        #     puts "you put a symbol in here, you peasant!"
        # else
        #     list_jobs_by_location(JsaajseApp::Job.locations.sort[input])
        # end
    end

    def prompt_return_to_mainscreen
        puts "Input [list] to view the location options"
        puts "Input [exit] to exit the app"

        input = gets.strip.downcase
        if input == "list" 
            unique_locations() 
            prompt_location_selection()
        elsif input == "exit"
            exit
        else
            puts "invalid input!"
            prompt_return_to_mainscreen
        end
    end

    def list_jobs_by_location(city)
        puts "Junior Software Developer Jobs: #{city.upcase}"

        if city == "Across Australia" 
            JsaajseApp::Job.all.map.with_index(1) do |job, i|
                puts "#{i}: #{job.job_title}"
                puts job.location
                puts "#{job.company_name}"
                puts job.statement
        
                puts job.url
        
                divider()
                divider()
            end
        else
            JsaajseApp::Job.all.map.with_index(1) do |job, i|
                if job.location.include?(city)

                    puts "#{i}: #{job.job_title}"
                    puts job.location
                    puts "#{job.company_name}"
                    puts job.statement

                    puts job.url

                    divider()
                    divider()
                end
            end
        end
        prompt_return_to_mainscreen
    end
end