# Ansible playbook for Hetzner

[![Ansible Lint](https://github.com/palark/hetzner-bare-metal-ansible/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/palark/hetzner-bare-metal-ansible/actions/workflows/ansible-lint.yml)

Find more details about this playbook (e.g., how it works and what it does) in [this article](https://blog.palark.com/ansible-hetzner-bare-metal-linux/).

## Using this playbook

To run the Ansible playbook, use the following command:

```bash
ansible-playbook playbook.yml -i inventory/hosts.ini
```

You can also execute specific stages of the playbook by using tags such as `hetzner_bootstrap`, `install_os`, `features`, or any feature tag. For example:
```bash
ansible-playbook playbook.yml -i inventory/hosts.ini --tags "install_packages"
```
To enable verbose output, use the -vvv flag. For example:
```bash
ansible-playbook playbook.yml -i inventory/hosts.ini --tags "install_packages" -vvv
```

### Important notes

Before running the Ansible playbook, you need to add a new host to `inventory/hosts.ini`. For example:
```ini
[hetzner_init]
bare-metal-01 hetzner_ip=1.2.3.4 server_id=1234567
[nodes]
bare-metal-01 ansible_host=1.2.3.4 ansible_user=root ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_python_interpreter=/usr/bin/python3
```

If you decide to configure additional network interfaces, enable the `setup_network` feature flag in `group_vars/all.yml`, prepare a template for the `netplan` configuration and place it in the `host_vars` directory, naming it `{{ inventory_hostname }}.yml`. For example:
```
host_vars/bare-metal-01.yml
```
- The configuration file should include information on the internal and external interface settings.
- The server's ID and external IP address can be found in the [Hetzner Robot Console](robot.hetzner.com).

In the file `group_vars/all.yml`, specify the user and password for the Hetzner API. You can create this user in Robot via the user menu in the upper right corner under "Settings" -> "Web service and app settings".

### WARNING
Running the full playbook or the `install_os` stage will **erase all data on the disks**. Make sure the server's ID and external IP address are correct and double-check that this is the server you want to bootstrap.

### Feature flags

- `setup_network`: Enable the additional network configuration for several network interfaces.
- `set_cpu_governor_performance`: By default, the CPU governor is set to the `powersave` mode, which can cause unexpected side effects and poor performance. Set this flag to `true` to switch to the `performance` mode.
- `install_packages`: Install additional packages from the given list.
- `create_users`: Create additional OS users, add their public keys, and set the default password with the forced policy to change it on the first login. Public keys should be added to the `roles/create_users/files` directory.

## Planned improvements

1. Automation for joining nodes to the Kubernetes cluster.
2. Linting errors.
3. RAID creation. Currently, `install_os` is designed to create RAID 1 from two disks (`nvme0n1` and `nvme1n1`). Disk names need to be dynamically determined. At this point, if there are more than two disks connected to the system, manual adjustments to `roles/install_os/tasks/main.yml` at line 11 are required.
