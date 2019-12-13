let Sub = {
  init(socket, me, room) {

    let channel = socket.channel('room:' + room, {})
    channel.join().receive("ok", resp => { console.log(me+ " joined room: " + room + " successfully", resp) })

    this.listenForChats(channel)
  },

  listenForChats(channel) {
    function submitForm(){
    let userName = document.getElementById('user-name').value
    let userMsg = document.getElementById('user-msg').value

    channel.push('shout', {name: userName, body: userMsg})
      document.getElementById('user-name').value = userName
      document.getElementById('user-msg').value = userMsg
    }

    document.getElementById('chat-form').addEventListener('submit', function(e){
      e.preventDefault()
      submitForm();
    })

    channel.on('shout', payload => {
      let chatBox = document.querySelector('#chat-box')
      let msgBlock = document.createElement('p')

      msgBlock.insertAdjacentHTML('beforeend', `${payload.name}: ${payload.body}`)
      chatBox.appendChild(msgBlock)
    })
  }
}

export default Sub
