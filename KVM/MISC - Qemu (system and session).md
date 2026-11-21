KVm différences `qemu:///system` and qemu:///session

La distinction entre **`qemu:///system`** et **`qemu:///session`** réside dans le niveau de privilèges et la portée de la gestion des machines virtuelles via libvirt.

**`qemu:///system`** se connecte au démon libvirtd global qui s'exécute avec les privilèges **root**. Ce mode est destiné à la **virtualisation serveur ou de production**, offrant un contrôle total sur le réseau (ponts, bridges), le stockage partagé et le démarrage automatique des VM sans session utilisateur active. Les configurations sont stockées dans `/etc/libvirt/` et `/var/lib/libvirt/`, et l'accès est généralement restreint aux membres du groupe `libvirt`.

**`qemu:///session`** se connecte à un démon libvirt par **utilisateur**, s'exécutant sans privilèges root. Ce mode est idéal pour les **tests locaux et le bureau**, garantissant une isolation totale où chaque utilisateur possède ses propres VM stockées dans son répertoire personnel (`~/.config/libvirt/`). Il présente des limitations notables, notamment un support réseau restreint (souvent limité au mode utilisateur/SLIRP ou nécessitant une configuration manuelle pour les ponts) et l'impossibilité de gérer les VM sans que l'utilisateur soit connecté.

| Caractéristique | `qemu:///system` | `qemu:///session` |
| :--- | :--- | :--- |
| **Exécution** | Privilèges root (système) | Privilèges utilisateur (session) |
| **Usage principal** | Serveurs, production, homelab | Développement local, tests, bureau |
| **Stockage** | `/etc/libvirt/`, `/var/lib/libvirt/` | `~/.config/libvirt/` |
| **Réseau** | Complet (ponts, VLAN, NAT avancé) | Limité (NAT utilisateur, SLIRP) |
| **Autonomie** | Démarrage sans session utilisateur | Nécessite une session utilisateur active |

En résumé, utilisez **`qemu:///system`** pour des workloads nécessitant une intégration réseau et stockage poussée, tandis que **`qemu:///session`** convient pour une virtualisation isolée et sans risque pour l'hôte.