#!/bin/bash
#FLUX: --job-name=crunchy-pot-5842
#FLUX: --queue=week-long-std
#FLUX: -t=86400
#FLUX: --priority=16

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
