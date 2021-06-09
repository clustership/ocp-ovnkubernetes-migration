#!/usr/bin/env ansible-playbook
---
# If you like to play: ./ansible/create.yml --skip-tags public_dns,letsencrypt
- hosts: localhost
  connection: local
  gather_facts: true
  vars_files:
  - ../cluster.yml

  tasks:
  - name: Migrate to OVNKubernetes
    import_role:
      name: ocp4-ovnkubernetes-migration
      tasks_from: cleanup.yml
    vars:
      kubeconfig: "{{ lookup('env', 'KUBECONFIG') }}"
      k8s_validate_certs: false
