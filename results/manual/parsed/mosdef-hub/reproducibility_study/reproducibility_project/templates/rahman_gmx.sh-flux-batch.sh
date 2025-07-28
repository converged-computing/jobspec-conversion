#!/bin/bash
#FLUX: --job-name=frigid-signal-2733
#FLUX: --queue=week-long-std
#FLUX: -t=86400
#FLUX: --urgency=16

{% extends "slurm.sh" %}
{% block header %}
{% set gpus = operations|map(attribute='directives.ngpu')|sum %}
    {{- super () -}}
module load anaconda/3.9
source activate mosdef-study38
module load gromacs/2020.6
{% endblock header %}
{% block body %}
    {{- super () -}}
{% endblock body %}
