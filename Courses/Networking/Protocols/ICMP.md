## ICMP Overview

ICMP or Internet Control Message Protocol is used to analyze various nodes on a network. This is most commonly used with utilities like ping and traceroute.

![[ICMP frames.png]]

### ICMP request 

Below we see packet details for a ping request packet. There are a few important things within the packet details that we can take note of first being the type and code of the packet. A type that equals 8 means that it is a request packet, if it is equal to 0 it is a reply packet. When these codes are altered or do not seem correct that is typically a sign of suspicious activity.

There are two other details within the packet that are useful to analyze: timestamp and data. The timestamp can be useful for identifying the time the ping was requested it can also be useful to identify suspicious activity in some cases. We can also look at the data string which will typically just be a random data string.

![[ICMP Request.png]]


### ICMP reply

Below you can see that the reply packet is very similar to the request packet. One of the main difference that distinguishes a reply packet is the code, in this case, you can see it is 0, confirming that it is a reply packet.

![[ICMP Reply.png]]