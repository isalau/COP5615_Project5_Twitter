let Sub = {
  init(socket,room) {

    let channel = socket.channel('room:' + room, {})
    channel.join()

    this.listenForChats(channel)
  },

  listenForChats(channel) {

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
