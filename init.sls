
include:
{% if pillar.virtualbox.host is defined %}
- virtualbox.host
{% endif %}
