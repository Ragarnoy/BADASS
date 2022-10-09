# What is the difference between `Broadcast` and `Multicast`

To send network traffic (data) from a source to a destination, we have multiple way/method to achieve that.
2 of them are `Broadcast` and `Multicast`, But what is the difference between the two ?

## When using the `Broadcast` method

The sender will send the message using the broadcast address.
This will result in all of the reachable devices on the network to receive the message.

### Pros about using the `Broadcast` method

- The sender don't need to know information about the receiver.

### Cons about using the `Broadcast` method

- By sending to each rechable devices on the network, that can result in flooding the network.

## When using the `Multicast` method

In this method, the sender will send the traffic to a group of hosts / devices (that mostly be a subset of the reachable devices on the network).

### Pros about using the `Multicast` method

- Traffic is only sent to a specific sub-set of devices on the network

### Cons about using the `Multicast` method

- Multicast Group need to be configured

## Sources

- [Broadcasting - Wikipedia](https://en.wikipedia.org/wiki/Broadcasting_(networking))
- [Multicast - Wikipedia](https://en.wikipedia.org/wiki/Multicast)
