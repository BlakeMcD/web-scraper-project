class JsaajseApp::JobCLI 

    def initialize
        JsaajseApp::Scraper.new.make_jobs_for_multiple_pages
    end

    def start
        system("clear")
        divider_equals
        puts "Welcome to JSAAJSE - an app that searches seek.com.au for Australian junior software engineer roles." 
        divider_equals
        new_line
        puts "CITY SELECTION"
        divider
        unique_locations 
        prompt_location_selection

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
        puts "------------------"
    end

    def divider_equals
        puts "=================="
    end



    def contains_letter_or_symbol(str)
        str.match(/[\D]/)
    end

    #prompt user
    def prompt_location_selection

        divider
        puts "Type the number of the location you would like to search:"
        new_line

        input = gets.strip.to_i

        if input == 0 || input > JsaajseApp::Job.locations.length 
            puts "you done messed up!"
            JsaajseApp::Job.clear_locations
            unique_locations
            prompt_location_selection
        # elsif contains_letter_or_symbol(input)
        #     puts "you put a symbol in here, you peasant!"
        else
            list_jobs_by_location(JsaajseApp::Job.locations.sort[input-1])
        end
    end

    def prompt_return_to_mainscreen
        puts "Input [list] to view the location options"
        puts "Input [exit] to exit the app"

        input = gets.strip.downcase
        if input == "list" 
            unique_locations
            prompt_location_selection
        elsif input == "exit"
            exit
        else
            puts "invalid input!"
            prompt_return_to_mainscreen
        end
    end

    def list_jobs_by_location(city)
        new_line
        divider_equals
        puts "#{city.upcase} - JUNIOR SOFTWARE ENGINEERING ROLES: "
        divider_equals
        new_line

        if city == "Across Australia" 
            JsaajseApp::Job.all.map.with_index(1) do |job, i|
                puts "#{i}: #{job.job_title}"
                puts job.location
                puts "#{job.company_name}"
                puts job.statement
        
                puts job.url
        
                divider
                divider

            end
        else
            JsaajseApp::Job.all.map.select do |job|

                if job.location.include?(city)
                    JsaajseApp::Job.city_array << job
                end
                
            end
            JsaajseApp::Job.city_array.map.with_index(1) do |job, i|
                puts "LSTING NUM:  #{i}"
                puts "COMPANY:     #{job.company_name}"
                puts "TITLE:       #{job.job_title}"
                puts "DESCRIPTION: #{job.statement}"
                puts "POSTING URL: #{job.url}"
                divider
            end
        end
        prompt_return_to_mainscreen
    end
end






# if city == "Across Australia" 
#     JsaajseApp::Job.all.map.with_index(1) do |job, i|
#         puts "#{i}: #{job.job_title}"
#         puts job.location
#         puts "#{job.company_name}"
#         puts job.statement

#         puts job.url

#         divider
#         divider
#     end
# else
#     JsaajseApp::Job.all.map.with_index(1) do |job, i|
#         if job.location.include?(city)

#             puts "#{i}: #{job.job_title}"
#             puts job.location
#             puts "#{job.company_name}"
#             puts job.statement

#             puts job.url

#             divider
#             divider
#         end
#     end
# end