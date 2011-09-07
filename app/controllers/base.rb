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
    filename = "#{"%04x%04x%04x%04x%04x%06x%06x" % [rand(0x0010000),rand(0x0010000),rand(0x0010000),rand(0x0010000),rand(0x0010000),rand(0x1000000),rand(0x1000000)]}.html"
    File.open(File.join(settings.public, filename), "w+") {|f| f.write(render("postinfo"))}
    pubnub = Pubnub.new(
      PUBNUB_PUBKEY,  ## PUBLISH_KEY
      PUBNUB_SUBKEY,  ## SUBSCRIBE_KEY
      "",             ## SECRET_KEY
      PUBNUB_SSL      ## SSL_ON?
    )
    txt = ""
    # got a subject?
    if params["subject"].nil?
      # no subject
      # got an event?
      if params["event"].nil?
        # no event
        txt = "not sendgrid"
      else
        # has event
        txt = "event: #{params["event"]}"
      end
    else
      # has subject
      txt = "email: #{params["subject"]}"
    end
    
    pubnub.publish({
      "channel" => "testing_sendgrid_#{PUBNUB_CHANNEL}",
      "message" => { "file" => "/#{filename}", "txt" => txt }
    })
    "ok"
  end
  
end
