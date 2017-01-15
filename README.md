# ansible-playground-vagrant

## About Ansible
Ansible is an automation engine used for provisioning, configuration management and deployments. Ansible uses an agentless architecture, which means that you don't have to install any additional software on your nodes. To manage your nodes with ansible, you will need a working SSH daemon and Python interpreter.

## Vagrant environment
Provided Vagrantfile will setup 4 virtual machines (1 manager, 3 managed nodes)
```
192.168.10.2 manager
192.168.10.3 node01
192.168.10.4 node02
192.168.10.5 node03
```

Provisioning scripts will install ansible on manager vm, setup passwordless authentication between manager and nodes and add some entries to hosts file, so you can use domain names and forget about IP addresses.

## Let's play
### Setup
```
$ vagrant up
$ vagrant ssh manager
```
On manager:
```
$ ping node01
```
Let's look at the ansible config file (/home/ubuntu/ansible.cfg). It says that our default user on nodes is ubuntu and we want to use sudo to gain more privileges.


### Inventory
Ansible does not know anything about managed nodes, we need to define a file called inventory and put IP addresses/names of our nodes.
Let's call it `hosts`
```
$ vi hosts
```
and put there:
```
node01
node02
node03
```

Now we can check our setup:
```
ansible -i hosts -m ping all
```
and gather some facts about nodes:
```
ansible -i hosts -m setup all
```

### First playbook
Let's create a file called `nginx.yml` and write our first playbook:
```
---
- hosts: all
  tasks:
    - name: update apt cache
      apt: update_cache=yes

    - name: install nginx
      apt: name=nginx state=present
```
Now we should be able to execute it on our nodes:
```
$ ansible-playbook -i hosts nginx.yml
```

Just to be sure, check if nginx is really working:
```
$ http node01
$ http node02
$ http node03
```
You should be able to see default nginx page, pretty boring, right?

### Templates
Create a directory `templates` and file `index.html.j2`:
```
$ mkdir templates
$ vi templates/index.html.j2
```

```
Hello from {{ansible_hostname}}!
```

then edit our playbook and add another task:
```
---
- hosts: all
  tasks:
    - name: update apt cache
      apt: update_cache=yes

    - name: install nginx
      apt: name=nginx state=present

    - name: change index.html
      template: 
        src: index.html.j2 
        dest: /usr/share/nginx/html/index.html
        owner: root
        group: root
        mode: 0755
```
and execute it!
```
$ ansible-playbook -i hosts nginx.yml
```
Yay, now our configuration is depending on a variable (remember the gathering facts part?). 

### Ansible Galaxy and roles
Install `DavidWittman.redis` role from Ansible Galaxy
```
$ sudo ansible-galaxy install DavidWittman.redis
```

