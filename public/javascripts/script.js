PUBNUB.subscribe({
  channel: "testing_sendgrid",
  callback: function(message) { 
    PUBNUB.attr(PUBNUB.$("report"), "src", message["file"]);
    $("#links").append("<li><a href='"+message["file"]+"' target='report'>"+message["txt"]+"</a></li>")
  },
  error: function(e) {
    console.log(e);
  }
})