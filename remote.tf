resource "null_resource" "MySqlOciRemote" {

  depends_on = [oci_core_instance.MySqlOciInstance]

  provisioner "remote-exec" {
    inline = ["echo I am in ",
              "hostname",
              "python3 --version",
              "sleep 10",
              "sudo apt update",
              "sudo apt install -y firewalld",
              "sleep 5",
              "sudo firewall-cmd --add-port=3306/tcp --permanent",
              "sudo firewall-cmd --add-port=3307/tcp --permanent",
              "sudo firewall-cmd --add-port=33060/tcp --permanent",
              " sudo firewall-cmd --reload",
              "sleep 5",
              "sudo apt install -y snapd",
              "sudo snap install mysql-shell"]
    
    connection {
      type = "ssh"
      user = "ubuntu"
      host = data.oci_core_vnic.MySqlOciVNICprimary.public_ip_address
      private_key = file(var.private_key_path)
   } 

}
   provisioner "local-exec" {

     command = "ansible-playbook -i '${data.oci_core_vnic.MySqlOciVNICprimary.public_ip_address},' --private-key ${var.private_key_path} ./mysql.yml  -u ubuntu"

   }


}
