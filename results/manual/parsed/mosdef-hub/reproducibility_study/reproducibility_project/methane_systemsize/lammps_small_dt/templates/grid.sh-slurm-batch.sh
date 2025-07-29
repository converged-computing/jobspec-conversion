#!/bin/bash
#SBATCH --output=output-%j.dat
#SBATCH --error=error-%j.dat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:{{
#SBATCH --constraint=v100,intel

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
