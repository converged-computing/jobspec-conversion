#!/bin/bash
#FLUX: --job-name={{ id }}
#FLUX: --queue={{
#FLUX: -t=719999
#FLUX: --urgency=16

{% extends "slurm.sh" %}
{% block header %}
module purge
module load anaconda
source activate mosdef-study38
date >> execution.log
{% if partition %}
{% endif %}
{% if nodelist %}
{% endif %}
{% endblock %}
