import consumer from "channels/consumer"

function checkChange(element, value, isZero = false) {
  element.className = ""
  element.innerText = value;
  element.className = Number(element.innerText) > (isZero ? 0 : value) ? 'row-green-change' : 'row-red-change';
}

consumer.subscriptions.create({ channel: 'PriceChangeChannel', room: "all" },
  {
    // Called when there's incoming data on the websocket for this channel
    received(data) {
      const target = document.getElementById(`coin-${data.short_name}`)

      if (target == null) return;

      const targetChildren = target.getElementsByTagName('td')

      checkChange(targetChildren[3], data.price);
      checkChange(targetChildren[4], data.change_24h, true);

    }
  });
