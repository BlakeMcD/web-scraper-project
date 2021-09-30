require 'open-uri'
require 'nokogiri'

require_relative './job.rb'

class Scraper

    url = "https://www.seek.com.au/junior-software-engineer-jobs/in-All-Australia/full-time?salaryrange=70000-999999&salarytype=annual"
    html = open(url)

    def get_page
        Nokogiri::HTML(html)
    end

    def get_jobs
        self.get_page.css("div._1UfdD4q")
    end

    def make_jobs
       self.get_courses.each do |post|
            job = Job.new
            job.job_title = post.css(div article span._3mgsa7- _2X_OUt_ _1WgeL1f _3VdCwhL _2Ryjovs h1 a.text)
            job.company_name
            job.location
            job.statement
            job.url
        end 
    end

end

