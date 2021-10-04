require "nokogiri"
require "open-uri"

class ScraperJobPage

    def get_page
        url = "https://www.seek.com.au/job/54123423?type=promoted#searchRequestToken=9d2f2f25-24c1-4178-973c-b2240f331953"
        html = open(url)
        doc = Nokogiri::HTML(html)
    end

    def get_details
        self.get_page.css("div.yvsb870").text.strip
    end

    def make_jobs
       self.get_jobs.map do |post|

            base_url = "https://www.seek.com.au/"

            post.css("span._2OKR1ql").text.strip

            # job = JsaajseApp::Job.new

            # job.job_title = post.css("h1").text.strip 
            # job.company_name = post.css("span._3mgsa7- a._17sHMz8").first["title"].strip.gsub('Jobs at ','') 
            # job.location = post.css("span._3mgsa7- strong._7ZnNccT a._17sHMz8").text.strip.gsub('Information & Communication Technology','') 
            # job.statement = post.css("span._2OKR1ql").text.strip
            # job.url = base_url+post.css("h1 a").first["href"] 
        end
    end

    # def make_jobs_for_multiple_pages
    #     puts "Loading jobs"
    #     while @@page_number < MAXPAGE 
    #         print "="
    #         make_jobs
    #         @@page_number += 1
    #     end
    # end
end

p ScraperJobPage.new.get_details
# p Job.all
