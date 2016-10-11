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

  logger.info("Accessing to https://boss-cp.jp")
  driver.navigate.to "https://boss-cp.jp"

  logger.info("age check")
  twenty_button = driver.find_element(:id => "check")
  twenty_button.click

  logger.info("Select twitter to apply")
  apply_with_twitter = driver.find_elements(:class => "fade")[0]
  apply_with_twitter.click

  logger.info("Twitter authentication")
  driver.find_element(:id => "username_or_email").send_keys twitterID
  driver.find_element(:id => "password").send_keys password
  driver.find_element(:id => "allow").click

  logger.info("Input apply comment")
  driver.find_element(:id => "text_length").send_keys apply_comment
  driver.find_elements(:tag_name => "button")[0].click

  logger.info("Confirm")
  driver.find_elements(:class => "fade")[1].click

  sleep 5

  result_string = driver.find_element(:class => "group")
      .find_elements(:tag_name => "img")[0].attribute("src")
  ResultNotify.notify(result_string,twitterID)
  logger.info(result_string)

rescue => e
    puts e
ensure
  sleep 3 
  driver.quit
end
