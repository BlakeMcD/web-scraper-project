class JsaajseApp::JobCLI 

    def start
        system("clear")
        divider_equals
        puts "Welcome to JSAAJSE - an app that searches seek.com.au for Australian junior software engineer roles." 
        divider_equals
        page_selection
    end

    #Unique locations - goes through entire list, populates an array of unique locations stored in job.rb
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
        puts "------------------"
    end

    def divider_equals
        puts "=================="
    end

    def city_selection
        new_line
        puts "CITY SELECTION"
        divider
        unique_locations 
        prompt_location_selection
    end

    def page_selection
        new_line
        puts "PAGE SELECTION"
        divider
        puts "how many pages would you like to scrape?"
        divider
        prompt_page_number_selection
    end

    def problematic_input
        new_line
        puts "What kind of an input was that?!?"
        new_line
        dissapointed_face
        new_line
        puts "please try again..."
    end

    #Clearing Functions
    def clear_city_array
        JsaajseApp::Job.city_array_reset_all
    end

    def clear_locations_array
        JsaajseApp::Job.locations_reset_all
    end

    def clear_jobs_array
        JsaajseApp::Job.reset_all
    end

    def clear_city_and_locations_array
        clear_city_array
        clear_locations_array
    end

    def clear_everything
        clear_city_array
        clear_locations_array
        clear_jobs_array
    end

    #ASCII
    def dissapointed_face
        puts "       ಠ_ಠ"
    end

    #prompts
    def prompt_page_number_selection
        new_line
        puts "Please select a number between 1 - 50:"
        new_line

        input = gets.strip.to_i

        if input == 0 || input > 50
            problematic_input
            page_selection
        else
            JsaajseApp::Scraper.page_number_reset
            clear_everything
            $max_page = input
            JsaajseApp::Scraper.new.make_jobs_for_multiple_pages
            city_selection
        end
    end

    def prompt_location_selection

        divider
        puts "Type the number of the location you would like to search:"
        new_line

        input = gets.strip.to_i

        if input == 0 || input > JsaajseApp::Job.locations.length 
            clear_locations_array
            problematic_input
            city_selection
        else
            list_jobs_by_location(JsaajseApp::Job.locations.sort[input-1])
        end
    end

    def prompt_return_to_mainscreen
        puts "Input [list] to view the location options"
        puts "Input [pages] to change the number of pages you'd like to scrape"
        puts "Input [exit] to exit the app"
        new_line

        input = gets.strip.downcase

        case input
            when "list"
                clear_city_and_locations_array
                city_selection
            when "pages"
                clear_everything
                page_selection
            when "exit"
                exit
            else
            input_value = input.to_i
                if input_value > 0 && input_value <= JsaajseApp::Job.city_array.length 
                    job = JsaajseApp::Job.city_array[input_value-1]
                    JsaajseApp::Scraper.scrape_job_page(input_value) if job.job_details == nil
                    system("clear")
                    puts job.job_details
                    new_line
                    prompt_return_to_mainscreen
                else
                    problematic_input
                    new_line
                    prompt_return_to_mainscreen
                end
        end
    end

    #display results
    def list_jobs_by_location(city)
        new_line
        divider_equals
        puts "#{city.upcase} - JUNIOR SOFTWARE ENGINEERING ROLES: "
        divider_equals
        new_line

        if city == "Across Australia" 
            JsaajseApp::Job.all.map.with_index(1) do |job, i|
                puts "LISTING NUM: #{i}"
                puts "LOCATION:    #{job.location}"
                puts "COMPANY:     #{job.company_name}"
                puts "TITLE:       #{job.job_title}"
                puts "DESCRIPTION: #{job.statement}"
                puts "POSTING URL: #{job.url}"
                divider
            end
        else
            JsaajseApp::Job.city_array = JsaajseApp::Job.all.select { |job| job.location.include?(city) }
                
            JsaajseApp::Job.city_array.each.with_index(1) do |job, i|
                puts "LISTING NUM:  #{i}"
                puts "COMPANY:     #{job.company_name}"
                puts "TITLE:       #{job.job_title}"
                puts "DESCRIPTION: #{job.statement}"
                puts "POSTING URL: #{job.url}"
                divider
            end
        end
        puts "Input a job's listing number if you'd like to find out more about it."
        prompt_return_to_mainscreen
    end
end





