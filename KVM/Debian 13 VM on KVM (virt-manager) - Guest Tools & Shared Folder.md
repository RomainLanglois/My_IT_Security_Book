
## 1. Guest tools

```bash
sudo apt update
sudo apt install qemu-guest-agent spice-vdagent
sudo systemctl enable --now qemu-guest-agent
```

| Package            | Provides                                                       |
| ------------------ | -------------------------------------------------------------- |
| `qemu-guest-agent` | Clean shutdown, consistent snapshots, guest IP shown on host   |
| `spice-vdagent`    | Shared clipboard, auto display resize (re-login after install) |

**Required VM hardware** (usually present by default):
- Channel `org.qemu.guest_agent.0` (unix)
- Channel `com.redhat.spice.0` (spicevmc)
- Display: Spice · Video: Virtio or QXL

**Verify**
```bash
systemctl status qemu-guest-agent           # on the guest machine
```

## 2. Shared folder (virtiofs)

### Host
```bash
sudo apt install virtiofsd
mkdir -p ~/vmshare
```
- **Shut down** the VM (fully powered off).

### virt-manager
1. VM details → **Memory** → tick **Enable shared memory** → Apply
2. **Add Hardware → Filesystem**
   - Driver: `virtiofs`
   - Source path: `/home/youruser/vmshare`
   - Target path: `hostshare` (mount tag, not a path)
3. Start the VM.

> Older virt-manager without the checkbox: add to the VM XML:
> ```xml
> <memoryBacking>
>   <source type="memfd"/>
>   <access mode="shared"/>
> </memoryBacking>
> ```

### Guest
```bash
sudo mkdir -p /mnt/hostshare
sudo mount -t virtiofs hostshare /mnt/hostshare
```
Permanent mount in `/etc/fstab`:
```
hostshare   /mnt/hostshare   virtiofs   defaults,nofail   0   0
```

**Notes**
- File ownership passes through by UID: match host/guest UIDs (check with `id`).
- Fallback: driver `virtio-9p` (no shared memory needed):
  `sudo mount -t 9p -o trans=virtio hostshare /mnt/hostshare`