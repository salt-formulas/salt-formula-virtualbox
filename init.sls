
include:
{% if pillar.virtualbox.hostnode is defined %}
- virtualbox.hostnode
{% endif %}
