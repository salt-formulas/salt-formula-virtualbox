
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

{% set virtualbox_base_url_fragments = [ 'http://download.virtualbox.org/virtualbox/', virtualbox_version ] %}
{% set virtualbox_base_url = virtualbox_base_url_fragments|join("") %}

{% set virtualbox_base_file_fragments = [ 'virtualbox-', virtualbox_major_version, '_', virtualbox_version, '-', virtualbox_build, '~', os, '~', os_codename, '_amd64.deb' ] %}
{% set virtualbox_base_file = virtualbox_base_file_fragments|join("") %}

{% endif %}

{%- if pillar.virtualbox.hostnode.enabled %}

include:
- virtualbox.params

{% if os == "Ubuntu" %}

virtualbox_packages:
  pkg.installed:
  - names:
    - fontconfig
    - fontconfig-config
    - libasound2
    - libasyncns0
    - libaudio2
    - libavahi-client3
    - libavahi-common-data
    - libavahi-common3
    - libcaca0
    - libcups2
    - libcurl3
    - libflac8
    - libfontconfig1
    - libgl1-mesa-dri
    - libgl1-mesa-glx
    - libglapi-mesa
    - libice6
    - libjpeg-turbo8
    - libjpeg8
    - libjson0
    - liblcms1
    - libllvm3.0
    - libmng1
    - libmysqlclient18
    - libogg0
    - libpulse0
    - libqt4-dbus
    - libqt4-declarative
    - libqt4-network
    - libqt4-opengl
    - libqt4-script
    - libqt4-sql
    - libqt4-sql-mysql
    - libqt4-xml
    - libqt4-xmlpatterns
    - libqtcore4
    - libqtgui4
    - libsdl1.2debian
    - libsm6
    - libsndfile1
    - libtiff4
    - libvorbis0a
    - libvorbisenc2
    - libvpx1
    - libx11-xcb1
    - libxcb-glx0
    - libxcursor1
    - libxdamage1
    - libxfixes3
    - libxi6
    - libxinerama1
    - libxmu6
    - libxrender1
    - libxt6
    - libxxf86vm1
#    - mysql-common
    - qdbus
    - ttf-dejavu-core
    - x11-common
    - build-essential
    - linux-source

virtualbox_download_package:
  cmd.run:
  - name: wget {{ virtualbox_base_url }}/{{ virtualbox_base_file }}
  - unless: "[ -f /root/{{ virtualbox_base_file }} ]"
  - cwd: /root
  - require:
    - pkg: virtualbox_packages

virtualbox_install_package:
  pkg.installed:
  - sources:
    - virtualbox-{{ virtualbox_major_version }}: {{ virtualbox_base_file }}
  - require:
    - cmd: virtualbox_download_package

virtualbox_setup_kernel_drivers:
  cmd.run:
  - name: /etc/init.d/vboxdrv setup
  - cwd: /root
  - require:
    - pkg: virtualbox_install_package

{% elif os == "Windows" %}

virtualbox_install_package:
  pkg.installed:
  - name: virtualbox_x64_en

{%- endif %}

{%- endif %}