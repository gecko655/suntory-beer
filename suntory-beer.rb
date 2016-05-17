require 'selenium-webdriver'
require 'logger'
require_relative 'result-notify.rb'


logger = Logger.new(STDOUT)

hostname = ENV["Hostserver_Hostname"]
twitterID = ENV["TwitterID"]
password = ENV["Password"]
apply_comment = "香風智乃さん"



logger.info("Initializing")
driver = Selenium::WebDriver.for :remote, :url => "http://"+hostname+":4444/wd/hub", :desired_capabilities => :chrome
begin
  driver.manage.timeouts.implicit_wait = 10

  logger.info("Accessing to http://p-strong5gv.jp/i/")
  driver.navigate.to "http://p-strong5gv.jp/i/"

  logger.info("Agree policy")
  driver.find_element(:xpath => "//input[@type='checkbox']").click
  driver.find_element(:xpath => "//button[@class='btn hover']").click
  

  logger.info("Twitter authentication")
  driver.find_element(:id => "username_or_email").send_keys twitterID
  driver.find_element(:id => "password").send_keys password
  driver.find_element(:id => "allow").click

  logger.info("Input apply comment")
  driver.find_element(:id => "tweetText").send_keys apply_comment
  driver.find_element(:xpath => "//button[@class='btn hover']").click

  logger.info("Confirm")
  driver.find_element(:xpath => "//button[@class='btn hover']").click

  sleep 5

  result_pic = driver.find_element(:class => "result-pic")
  img_url = result_pic["src"] 
  logger.info(img_url)
  ResultNotify.notify(img_url,twitterID)

rescue => e
    puts e
ensure
  sleep 3 
  driver.quit
end
