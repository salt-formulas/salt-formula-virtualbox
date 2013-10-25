{% set os = salt['grains.item']('os')['os'] %}

{% set os_codename = salt['grains.item']('oscodename')['oscodename'] %}

{% set cpu_arch = salt['grains.item']('cpuarch')['cpuarch'] %}

{% if pillar.virtualbox.hostnode.version is defined %}
{% set virtualbox_version = pillar.virtualbox.hostnode.version %}
{% else %}
{% set virtualbox_version = '4.3.0' %}
{% endif %}

{% if virtualbox_version == '4.2.18' %}
{% set virtualbox_major_version = '4.2' %}
{% set virtualbox_build = '88780' %}
{% elif virtualbox_version == '4.3.0'%}
{% set virtualbox_major_version = '4.3' %}
{% set virtualbox_build = '89960' %}
{% else %}
{#
TODO: Error state
#}
{% endif %}

{% if os == "Ubuntu" %}

{% set base_url_fragments = [ 'http://download.virtualbox.org/virtualbox/', virtualbox_version ] %}
{% set base_url = ""|join(base_url_fragments) %}

{% set base_file_fragments = [ 'virtualbox-', virtualbox_major_version, '_', virtualbox_version, '-', virtualbox_build, '~', os, '~', os_codename, '_amd64.deb' ] %}
{% set base_file = ""|join(base_file_fragments) %}

{% endif %}


{%- if pillar.virtualbox.hostnode.enabled %}

include:
- virtualbox.params

{% if os == "Ubuntu" %}

virtualbox_packages:
  pkg.installed:
  - names:
#    - libqtgui4
#    - libxcb-glx0
#    - libglapi-mesa
#    - libqt4-opengl
#    - libqt4-sql-mysql
#    - libsdl1
#    - libxcursor1
#    - libxinerama1
#    - libxmu6
    - build-essential

virtualbox_download_package:
  cmd.run:
  - name: wget {{ base_url }}/{{ base_file }}
  - unless: "[ -f /root/{{ base_file }} ]"
  - cwd: /root
  - require:
    - pkg: virtualbox_packages

{#
virtualbox_install_package:
  pkg.installed:
  - sources:
    - virtualbox-{{ virtualbox_major_version }}: {{ base_file }}
  - require:
    - cmd: virtualbox_download_package
#}

{#
virtualbox_install:
  cmd.run:
  sudo apt-get install virtualbox-{{ virtualbox_major_version }} --no-install-recommends
  - require:
    - cmd: virtualbox_download_package
#}

{% elif os == "Windows" %}

virtualbox_install_package:
  pkg.installed:
  - name: virtualbox_x64_en

{%- endif %}

{%- endif %}