require 'nokogiri'
require 'open-uri'
# require 'pry'

require_relative './job.rb'

class Scraper    

    def get_page
        url = "https://www.seek.com.au/junior-software-engineer-jobs?salaryrange=70000-999999&salarytype=annual"
        # url = "http://learn-co-curriculum.github.io/site-for-scraping/courses"
        html = open(url)
        doc = Nokogiri::HTML(html)
    end

    def get_jobs
        self.get_page.css("article")
        # self.get_page.css("article._37iADb_")
        # self.get_page.css(".post")
    end

    def make_jobs
       self.get_jobs.map do |post|
            # print "iteration in progress"
            
            # post.css("span._3mgsa7- a._17sHMz8").text.strip #issue - doesn't have unique tag
            # job = Job.new


            # job.job_title
            # post.css("h1").text.strip #WORKS! returns a string

            # job.location
            # post.css("span._3mgsa7- strong._7ZnNccT a._17sHMz8").text.strip.gsub('Information & Communication Technology','')  #maybe the best I can do is this, but then remove the information and technology bull #returns a string #haha, kinda got this to work...maybe there was a better way. 

            # job.statement
            # post.css("span._2OKR1ql").text.strip

            # job.url
            # post.css("h1").map { |anchor| anchor["href"]}
            base_url = "https://www.seek.com.au/"
            base_url+post.css("h1 a").first["href"] #it works! It grabs the url but needs the anchor tag. Also returns a string
        end
    end

end

p Scraper.new.make_jobs


