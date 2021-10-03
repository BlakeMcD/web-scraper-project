require 'nokogiri'
require 'open-uri'
# require 'pry'

require_relative './job.rb'

class Scraper    

    def get_page
        url = "https://www.seek.com.au/junior-software-engineer-jobs?salaryrange=70000-999999&salarytype=annual"
        html = open(url)
        doc = Nokogiri::HTML(html)
    end

    def get_jobs
        self.get_page.css("article")
    end

    def make_jobs
       self.get_jobs.map do |post|

            job = Job.new

            job.job_title = post.css("h1").text.strip 
            job.location = post.css("span._3mgsa7- strong._7ZnNccT a._17sHMz8").text.strip.gsub('Information & Communication Technology','') 
            job.statement = post.css("span._2OKR1ql").text.strip

            base_url = "https://www.seek.com.au/"
            job.url = base_url+post.css("h1 a").first["href"] 
        end
    end
end

Scraper.new.make_jobs
p Job.all


