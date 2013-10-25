
include:
- virtualbox.params
{% if pillar.virtualbox.hostnode is defined %}
- virtualbox.hostnode
{% endif %}
