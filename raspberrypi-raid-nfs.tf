# Assumes "3.2" section completed ahead of time: https://blog.alexellis.io/hardened-raspberry-pi-nas/#32createthepartitions	

variable "ip" {
  default = "127.0.0.1"
}

variable "password" {
  default = ""
}

resource "null_resource" "install-packages" {
  connection {
    type = "ssh"
    user = "pi"
    host = "${var.ip}"
    password = "${var.password}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -q update",
      "sudo apt-get install -yq vim mdadm",
      #"yes | sudo mdadm --create --verbose /dev/md0 --level=mirror --raid-devices=2 /dev/sda1 /dev/sdb1",
      #"sudo mkdir -p /mnt/raid1",
      #"sudo mkfs.ext4 /dev/md0",
      #"sudo mount /dev/md0 /mnt/raid1/",
      "ls -l /mnt/raid1/",
      "echo \"/dev/md0  /mnt/raid1/               ext4    defaults,noatime  0       1\" | sudo tee -a /etc/fstab",
      "sudo mdadm --detail --scan | sudo tee -a /etc/mdadm/mdadm.conf",
      "cat /etc/mdadm/mdadm.conf"
    ]
  }
}

