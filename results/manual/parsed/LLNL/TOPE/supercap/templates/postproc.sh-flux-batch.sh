#!/bin/bash
#FLUX: --job-name="{{ id }}"
#FLUX: --queue={{ partition }}
#FLUX: --priority=16

{% extends "base_script.sh" %}
{% block header %}
{% if partition %}
{% endif %}
{% if walltime %}
{% endif %}
{% if job_output %}
{% endif %}
module load opt mesa
module load paraview/5.10.0
{% endblock %}
