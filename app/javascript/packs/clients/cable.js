import cable from "actioncable";

let consumer;
const createChannel = (...args) => {
  if (!consumer) {
    consumer = cable.createConsumer();
  }

  return consumer.subscriptions.create(...args);
}

const cableDispatcher = (obj, func) => {
  createChannel(
  obj,
  {
    connected: () => {
      console.log(`Connected ${obj.id}`);
    },
    received: (data) => {
      func(data)
    }
  }
)}

export default cableDispatcher;
