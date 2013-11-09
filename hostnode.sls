
{% if pillar.virtualbox.hostnode.version is defined %}
{% set virtualbox_version = pillar.virtualbox.hostnode.version %}
{% else %}
{% set virtualbox_version = '4.3' %}
{% endif %}

{%- if pillar.virtualbox.hostnode.enabled %}

{% if grains.os == 'Ubuntu' %}

{% set kernel_version = salt['cmd.run']('uname -r') %}

virtualbox_repo:
  pkgrepo.managed:
  - human_name: Virtualbox
  - name: deb http://download.virtualbox.org/virtualbox/debian {{ grains.oscodename }} contrib
  - file: /etc/apt/sources.list.d/virtualbox.list
  - key_url: salt://virtualbox/conf/virtualbox-apt.gpg

virtualbox_packages:
  pkg.installed:
  - names:
    - build-essential
    - linux-headers-{{ kernel_version }}
    - dkms
    - virtualbox-{{ virtualbox_version }}
  - require:
    - pkgrepo: virtualbox_repo

virtualbox_setup_kernel_drivers:
  cmd.run:
  - name: /etc/init.d/vboxdrv setup
  - cwd: /root
  - require:
    - pkg: virtualbox_packages

{% elif grains.os == "Windows" %}

virtualbox_install_package:
  pkg.installed:
  - name: virtualbox_x64_en

{%- endif %}

{%- endif %}