#!/bin/bash
#SBATCH --job-name={{ id }}
#SBATCH --output=workspace/{{operations[0]._jobs[0]}}/job_%j.o
#SBATCH --error=workspace/{{operations[0]._jobs[0]}}/job_%j.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=8-07:59:59
#SBATCH --nodelist={{

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
