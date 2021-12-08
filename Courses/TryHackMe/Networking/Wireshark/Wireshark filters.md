### Filtering operators :

-   and - operator: and / &&
-   or - operator: or / ||
-   equals - operator: eq / ==
-   not equal - operator: ne / !=
-   greater than - operator: gt /  >
-   less than - operator: lt / <


### Examples and basic filtering :
- `ip.addr == <IP Address>`
- `ip.src == <SRC IP Address> and ip.dst == <DST IP Address>`
- `tcp.port eq <Port #> or <Protocol Name>`
- `udp.port eq <Port #> or <Protocol Name>`