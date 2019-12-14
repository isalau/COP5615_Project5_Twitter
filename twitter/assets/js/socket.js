// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()

  // var testarray = ["test1","test2","test3","test4","test5","test6"]
  // console.log("testarray array is "+ testarray)
  // for (const item in testarray) {
  //   console.log("value in testarray is "+ testarray[item])
  // }
  //
  // var msglist = document.getElementById("msglist");
  // let sprint = msglist.getAttribute("data-sname");
  // console.log("sprint array is "+ sprint)
  // for (const item in sprint) {
  //   console.log("value in sprint is "+ sprint[item])
  // }

let channelRoomId = window.channelRoomId
if (channelRoomId) {
  let channel = socket.channel(`room:${channelRoomId}`, {})

  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  // Now that you are connected, you can join channels with a topic:

  document.querySelector("#new-message").addEventListener('submit', (e) => {
    e.preventDefault()

    let messageInput = e.target.querySelector('#message-content')
    var msglist = document.getElementById("msglist");
    let messageSender = msglist.getAttribute("data-uname");
    console.log("tweet length is " + messageInput.value.length)
    if (messageInput.value.length < 280 && messageInput.value.length > 0){
      channel.push('message:add', { message: messageInput.value })
      document.getElementById("longtweet").innerHTML = ""
      messageInput.value = ""
    } else if (messageInput.value.length == 0) {
      document.getElementById("longtweet").innerHTML = "You can't send an empty tweet"
      messageInput.value = ""
    }else{
      document.getElementById("longtweet").innerHTML = "Your tweet is too long"
      messageInput.value = ""
    }
  });

  channel.on(`room:${channelRoomId}:new_message`, (message) => {
    console.log("message", message)
    renderMessageMe(message,channelRoomId)
  });
}

const renderMessageMe = function(message,name) {
  var m = message.content
  var msg = m + " - " + name
  let messageTemplate = `
      <p>${msg}</p>
  `
  document.querySelector("#yourtweets").innerHTML += messageTemplate
};

const renderMessage = function(message, name) {
  var m = message.content
  var msg = m + " - " + name
  let messageTemplate = `
      <p>${msg}</p>
  `
  document.querySelector("#yourfeed").innerHTML += messageTemplate
};

let subsRoomId = window.subRoomId
if (subsRoomId) {
  for (subRoomId in subsRoomId) {
    let channel = socket.channel(`room:${subsRoomId[subRoomId]}`, {})

    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    // Now that you are connected, you can join channels with a topic:

    document.querySelector("#new-message").addEventListener('submit', (e) => {
      e.preventDefault()
      var msglist = document.getElementById("msglist");
      let messageSender = msglist.getAttribute("data-uname");

      console.log("tweet length is " + messageInput.value.length)
      if (messageInput.value.length < 280 && messageInput.value.length > 0){
        channel.push('message:add', { message: messageInput.value })
        document.getElementById("longtweet").innerHTML = ""
        messageInput.value = ""
      }else{
        document.getElementById("longtweet").innerHTML = "Your tweet is too long"
        messageInput.value = ""
      }
    });

    channel.on(`room:${subsRoomId[subRoomId]}:new_message`, (message) => {
      console.log("message", message)
      var msgVal = message

      renderMessage(message, subsRoomId[subRoomId])
    });
  }
}

let retweetRoomId = window.retweetRoomId
if (retweetRoomId) {
  let channel = socket.channel(`room:${retweetRoomId}`, {})

  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  // Now that you are connected, you can join channels with a topic:

  document.querySelector("#new-message").addEventListener('submit', (e) => {
    e.preventDefault()

    let messageInput = e.target.querySelector('#message-retweet')
    console.log("pushed submit in retweet " + messageInput.value)
    // var msglist = document.getElementById("msglist");
    // let messageSender = msglist.getAttribute("data-uname");
    channel.push('message:retweet', { message: messageInput.value })
    messageInput.value = ""
  });

  channel.on(`room:${retweetRoomId}:new_message`, (message) => {
    console.log("message", message)
    renderMessageMe(message,retweetRoomId)
  });
}


export default socket
