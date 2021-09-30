require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './job.rb'

class Scraper    

    def get_page
        url = "https://www.seek.com.au/junior-software-engineer-jobs?salaryrange=70000-999999&salarytype=annual"
        html = open(url)
        doc = Nokogiri::HTML(html)
    end

    def get_jobs
        puts self.get_page.css("article._37iADb_ vwiJKjx")
        self.get_page.css("article._37iADb_ vwiJKjx")
    end

    def make_jobs
       self.get_jobs.each do |post|
            print "iteration in progress"
            # job = Job.new
            # job.job_title = post.css("div article span._3mgsa7- _2X_OUt_ _1WgeL1f _3VdCwhL _2Ryjovs h1 a").text
            # puts job.job_title
            # job.company_name = post.css("div article span._3mgsa7- _15GBVuT _2Ryjovs span span._2cFajGc a").text
            # job.location
            # job.statement
            # job.url
        end
    end

end

Scraper.new.get_jobs


