resource "oci_mysql_mysql_db_system" "mysql_create" {

    admin_password = var.mysql_db_system_admin_password

    admin_username = var.mysql_db_system_admin_username

    availability_domain = var.mysql_db_system_availability_domain

    compartment_id = oci_identity_compartment.MySqlOciCompartment.id

    shape_name = var.mysql_shape_name

    subnet_id = oci_core_subnet.MySqlOciSubnet.id

    ## this does not appear in required fields
    ## but it is a must to add it

    data_storage_size_in_gb = var.mysql_storage
}
