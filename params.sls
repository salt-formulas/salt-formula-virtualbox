
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

{% if virtualbox_version == '4.2.18' %}

{% if os == "Ubuntu" %}

{% set base_url_fragments = [ 'http://download.virtualbox.org/virtualbox/', virtualbox_version %}
{% set base_url = ""|join(base_url_fragments) %}

{% set base_file_fragments = [ 'virtualbox-', virtualbox_major_version, '_', virtualbox_version, '-', virtualbox_build, '~', os, '~', os_codename, '_amd64.deb' ]
{% set base_file = ""|join(base_file_fragments) %}

{% endif %}
