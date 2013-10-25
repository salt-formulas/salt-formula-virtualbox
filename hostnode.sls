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