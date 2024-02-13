# jellyfin

Follow this guide https://jellyfin.org/docs/general/administration/hardware-acceleration/intel.

Make sure the permissions on /dev/dri are ok for the jellyfin user - it needs to be in the render group.

sudo usermod -aG render jellyfin
sudo usermod -aG video jellyfin
