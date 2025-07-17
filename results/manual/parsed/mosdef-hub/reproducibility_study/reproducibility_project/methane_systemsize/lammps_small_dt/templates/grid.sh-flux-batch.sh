#!/bin/bash
#FLUX: --job-name=gloopy-butter-8317
#FLUX: --queue=primary
#FLUX: --urgency=16

{% extends "slurm.sh" %}
{% block header %}
{% set gpus = operations|map(attribute='directives.ngpu')|sum %}
    {{- super () -}}
{% if gpus %}
{%- else %}
{%- endif %}
echo  "Running on host" hostname
echo  "Time is" date
source ~/.bashrc
conda activate mosdef-study38
module load python/3.8
module swap gnu7 intel/2019
{% if gpus %}
module load cuda/11.0
{%- endif %}
{% endblock header %}
{% block body %}
    {{- super () -}}
{% endblock body %}
