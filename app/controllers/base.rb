SendGridTest.controllers  :base do
  require File.join(settings.root, "..", "vendor", "pubnub.rb")
  require File.join(settings.root, "..", "config", "pubnub_keys.rb")

  get :index, :map => "/" do
    render "index"
  end
  
  # can't post to / can only post to /asdasd so make it slash something
  # /mail - or you could make it /event for the event notifications
  # and then use /incoming for the incoming parser...
  post /.*/ do
    filename = "#{Time.now.to_i}.html"
    File.open(File.join(settings.public, filename), "w+") {|f| f.write(render("postinfo"))}
    pubnub = Pubnub.new(
      PUBNUB_PUBKEY,  ## PUBLISH_KEY
      PUBNUB_SUBKEY,  ## SUBSCRIBE_KEY
      "",             ## SECRET_KEY
      false           ## SSL_ON?
    )
    pubnub.publish({
      "channel" => "testing_sendgrid",
      "message" => { "file" => "/#{filename}", "to" => params["to"] }
    })
    "ok"
  end
    
end
