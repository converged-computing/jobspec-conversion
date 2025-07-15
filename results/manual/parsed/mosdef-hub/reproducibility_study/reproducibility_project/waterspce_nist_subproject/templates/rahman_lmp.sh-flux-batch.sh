#!/bin/bash
#FLUX: --job-name="{{ id }}"
#FLUX: -n=8
#FLUX: --queue=48hr-long-std
#FLUX: --priority=16

{% extends "slurm.sh" %}
{% block header %}
module load lammps/3Aug2022
{% endblock header %}
{% block body %}
	{{- super () -}}
{% endblock body %}
