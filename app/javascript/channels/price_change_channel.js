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
      const target = document.getElementById(`row-change-${data.short_name}`)

      if (target != null) {
        const targetChildren = target.getElementsByTagName('td')

        targetChildren[2].innerText = data.supply;
        targetChildren[3].innerText = data.market_cap;
        targetChildren[4].innerText = data.volume_24h;
        checkChange(targetChildren[5], data.price);
        checkChange(targetChildren[6], data.change_24h, true);
      }
    }
  });
