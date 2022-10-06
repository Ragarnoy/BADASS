# What is a network switch

A network switch connects devices within a network and forwards data packets to and from those devices.  
Unlike a router, a switch only sends data to the single device it is intended for, not to networks of multiple devices.

## Layer 2 and Layer 3 switches
Switches can operate on the layer 2 (via MAC addresses) or the layer 3 (via IP). Though some can do both, most switches are layer 2 switches.

## The CAM table
The way it can forward packets to the desired device is by keeping a table called CAM (Content Addressable Memory) table.
When a device sends a packet for the first time, the switch will update the CAM table with the MAC address and the port used by the device.
If the packet is for an unknown MAC address, it will simply send it to every other device (this is called `flooding`)
and update the CAM table when the target device answers.
