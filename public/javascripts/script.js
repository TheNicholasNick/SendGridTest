PUBNUB.subscribe({
  channel: "testing_sendgrid",
  callback: function(message) { 
    PUBNUB.attr(PUBNUB.$("report"), "src", message["file"]);
  },
  error: function(e) {
    console.log(e);
  }
})