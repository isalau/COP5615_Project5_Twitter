let Chat = {
  init(socket,room) {
    let channel = socket.channel('room:' + room, {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
  }
}
export default Chat
