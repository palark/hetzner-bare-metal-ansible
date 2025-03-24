hetzner-bare-metal-ansible
├── group_vars
│   └── all.yml
├── host_vars
│   └── bare-metal-01.yml
├── inventory
│   └── hosts.ini
├── playbook.yml
└── roles
    ├── create_users
    │   ├── files
    │   │   └── user.pub
    │   ├── handlers
    │   │   └── main.yml
    │   └── tasks
    │       └── main.yml
    ├── hetzner_bootstrap
    │   └── tasks
    │       └── main.yml
    ├── install_os
    │   └── tasks
    │       └── main.yml
    ├── install_packages
    │   └── tasks
    │       └── main.yaml
    ├── join_cluster
    │   └── tasks
    │       └── main.yml
    ├── prepare_ssh_key
    │   └── tasks
    │       └── main.yml
    ├── set_cpu_governor_performance
    │   ├── files
    │   │   ├── set-cpufreq.service
    │   │   └── set-cpufreq.sh
    │   └── tasks
    │       └── main.yml
    └── setup_network
        ├── tasks
        │   └── main.yml
        └── templates
            └── public_netplan_template.yaml.j2
