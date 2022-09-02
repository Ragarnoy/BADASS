# What is OSPF ?

`OSPF` (Open Shortest Path First) is an IP routing protocol that operates within a single Autonomous System (aka Interior Gateway Protocol or IGP).  
It relies on a DR (Designated Router) and a BDR (Backup Designated Router) to provide routing information to other routers.  
First, every router sets up a list of neighbors and transmits this list to all neighbors.  
Eventually, the DR and BDR will use theses lists to compute the shortest path to every destination, aka the routing table, with the help of the SPF (Shortest Path First) algorithm, which is based on Dijkstra's algorithm.  
A cost is also associated to each link, which is used to compute the shortest path. The cost is computed by the DR and BDR and is based mainly on the bandwidth.  

## Useful links
- [OSPF Design Guide](https://www.cisco.com/c/en/us/support/docs/ip/open-shortest-path-first-ospf/7039-1.html)
- [ELI5: OSPF](https://www.reddit.com/r/explainlikeimfive/comments/1j35qx/comment/cbaqnmk/?context=3)
