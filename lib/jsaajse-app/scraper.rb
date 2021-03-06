class JsaajseApp::Scraper    

    attr_accessor :page_number

    @@page_number = 1
    $max_page = 12

    def get_page
        url = "https://www.seek.com.au/junior-software-engineer-jobs?page=#{page_number}&salaryrange=70000-999999&salarytype=annual"
        html = open(url)
        doc = Nokogiri::HTML(html)
    end

    def get_jobs
        self.get_page.css("article")
    end

    def make_jobs
       self.get_jobs.map do |post|

            base_url = "https://www.seek.com.au/"

            job = JsaajseApp::Job.new

            job.job_title = post.css("h1").text.strip 
            job.company_name = post.css("span._3mgsa7- a._17sHMz8").first["title"].strip.gsub('Jobs at ','') 
            job.location = post.css("span._3mgsa7- strong._7ZnNccT a._17sHMz8").text.strip.gsub('Information & Communication Technology','') 
            job.statement = post.css("span._2OKR1ql").text.strip
            job.url = base_url+post.css("h1 a").first["href"] 
        end
    end

    def self.scrape_job_page(num)
        job = JsaajseApp::Job.city_array[num-1]

        html = open(job.url)
        job.job_details = Nokogiri::HTML(html).css("div[data-automation='jobAdDetails']").text.strip
        
    end

    def make_jobs_for_multiple_pages
        puts ""
        puts "Scraping pages"
        while @@page_number <= $max_page
            print "="
            make_jobs
            @@page_number += 1
        end
        puts ""
    end

    def self.page_number_reset
        @@page_number = 1
    end
end

# Scraper.new.make_jobs
# p Job.all




