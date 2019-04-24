# A shell script to mount the freedos virtual machine's virtual
# disk.

# Be sure to umount the partition and disconnect when you are done:

# umount /mnt && partx --delete /dev/nbd0 && qemu-nbd --disconnect /dev/nbd0

#  per http://ask.xmodulo.com/mount-qcow2-disk-image-linux.html

runUser=root
virtualDisk=/var/lib/libvirt/images/FreeDOS.1.2.qcow2

# This is the user for whom we will mount the virtual drive, so that
# user may read from and write to the virtual drive.
user=charles

uid=$(grep ${user} /etc/passwd | cut -d: -f 3)
gid=$(grep ${user} /etc/passwd | cut -d: -f 4)

if [ "$USER" != "$runUser" ] ; then
  echo Wrong user: you must be $runUser to run this script!
  exit 1
fi

#  harmless if redundant.
modprobe nbd max_part=8

qemu-nbd --connect=/dev/nbd0 ${virtualDisk}

fdisk /dev/nbd0 -l

# per https://gist.github.com/shamil/62935d9b456a6f9877b5
partx --add /dev/nbd0

mount -o uid=${uid},gid=${gid} /dev/nbd0p1 /mnt/

