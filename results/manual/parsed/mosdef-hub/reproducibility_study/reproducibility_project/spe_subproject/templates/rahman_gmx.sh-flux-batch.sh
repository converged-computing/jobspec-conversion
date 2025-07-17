#!/bin/bash
#FLUX: --job-name=evasive-lettuce-3068
#FLUX: --queue=standard
#FLUX: --urgency=16

{% extends "slurm.sh" %}
{% block header %}
{% set gpus = operations|map(attribute='directives.ngpu')|sum %}
    {{- super () -}}
{% if gpus %}
conda activate mosdef-study38
module load gromacs/2020.6
{% endblock header %}
{% block body %}
    {{- super () -}}
{% endblock body %}
