# racf-cert-manager-operator-collection
Operator Collection that allows for the creation and management of RACF certificates on a z/OS endpoint.

Based on the [certificate_managent z_ansible_collections_sample](https://github.com/IBM/z_ansible_collections_samples/tree/main/zos_concepts/certificate_management)

- [Playbooks](#playbooks)
  - [Create CA Cert](#create-ca-cert)
  - [Delete CA Cert](#delete-ca-cert)
  - [Create SITE Cert](#create-site-cert)
  - [Delete SITE Cert](#delete-site-cert)
  - [Create USER Cert](#create-user-cert)
  - [Delete USER Cert](#delete-user-cert)

## Playbooks
The playbooks and CustomResources provided by this OperatorCollection are listed below.

### Create CA Cert
The `createCACert` playbook creates a CERTAUTH certificate

### Delete CA Cert
The `deleteCACert` playbook deletes a CERTAUTH certificate

### Create Site Cert
The `createSiteCert` playbook creates a SITE certificate

### Delete Site Cert
The `deleteSiteCert` playbook deletes a SITE certificate

### Create User Cert
The `createUserCert` playbook creates a USER certificate

### Delete User Cert
The `deleteUserCert` playbook deletes a USERT certificate