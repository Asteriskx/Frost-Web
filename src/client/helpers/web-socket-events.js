class WebSocketEvents {
	static connectAsync(url) {
		return new Promise((resolve, reject) => {
			if (url == null)
				return reject(new Error('missing argumets'));

			const ws = new WebSocket(url);
			ws.addEventListener('error', errorEvent => { reject(errorEvent); });
			ws.addEventListener('close', closeEvent => { reject(closeEvent); });
			ws.addEventListener('open', () => {
				resolve(ws);
			});
		});
	}

	static init(ws) {
		if (ws == null)
			throw new Error('missing argumets');

		ws.addEventListener('message', messageEvent => {
			const {type, data} = WebSocketEvents.parse(messageEvent.data);
			const userEv = new Event(type);
			userEv.data = data;
			ws.dispatchEvent(userEv);
		});

		ws.sendEvent = (type, data) => {
			ws.send(WebSocketEvents.serialize(type, data));
		};
	}

	static serialize(type, data) {
		if (type == null || data == null)
			throw new Error('missing argumets');

		return JSON.stringify({
			type: type,
			data: data
		});
	}

	static parse(message) {
		if (message == null)
			throw new Error('missing argumets');

		const event = JSON.parse(message);

		if (event.type == null || event.data == null) {
			throw new Error('invalid event message');
		}

		return {
			type: event.type,
			data: event.data
		};
	}
}
module.exports = WebSocketEvents;