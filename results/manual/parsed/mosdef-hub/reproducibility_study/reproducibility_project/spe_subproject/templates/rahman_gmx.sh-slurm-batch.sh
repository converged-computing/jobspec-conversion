#!/bin/bash
#SBATCH --output=output-%j.log
#SBATCH --error=error-%j.log
#SBATCH --mail-user=co.d.quach@vanderbilt.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

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
