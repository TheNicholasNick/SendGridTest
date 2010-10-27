# SendGrid Tester

A simple ruby applicaiton to test if sendgrid.com post actions are working properly.

I was having trouble verifying that sendgrid was working with an application that I wasn't developing.
Needed a simple app that I could redirect certain URI's that could give information I needed, like sendgrid was sending info.
The appliation being developed is built in Java and is running in Tomcat fronted by nginx.
So all I had to do was put a location rule in nginx and proxy the request to this app instead of Tomcat.

## Running

      git clone http://github.com/SoreGums/SendGridTest.git
      cd SendGridTest
      bundle install --deployment
      cp config/pubnub_keys.sample.rb config/pubnub_keys.rb
      nano config/pubnub_keys.rb
      bundle exec padrino start

That's it once this is running and you have updated your sendgrid to point at this server open your browser to the root of this application and watch for stuff to happen.
(send an email to your parse incoming email domain, etc)

## Notes

* You are going to need an account from pubnub.com.
* You need to put your keys in the file at config/pubnub_keys.rb
* set the post url's to something other than bare "/"
* it would be good if it had a backwards, forwards, pause button - let me know if you do this ;)

# About Sendgrid

Email Delivery. Simplifed.

[SendGrid](http://www.sedngrid.com) transparently handles DKIM, SPF, ISP rate limits, content inspection, bounces, and spam reports to help users achieve higher deliverability. SendGrid integrates in minutes by just changing three SMTP settings.

# About PubNub

[PubNub](http://www.pubnub.com) is a cloud-based service for broadcasting real-time messages to thousands of web and mobile clients simultaneously. PubNub provides client libraries for all major programming languages and mobile platforms to make real-time development as easy as pie. PubNub is tuned for gaming performance and will shine with any application. Build real-time web-scale applications such as analytics, tickers, games, messaging, tweets and more! 
