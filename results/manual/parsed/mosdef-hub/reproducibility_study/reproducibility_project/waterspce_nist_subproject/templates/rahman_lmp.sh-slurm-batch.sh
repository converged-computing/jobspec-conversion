#!/bin/bash
#SBATCH --job-name={{ id }}
#SBATCH --output=test_job_out.txt
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2g
#SBATCH --time=2-00:00:00
#SBATCH --partition=48hr-long-std

{% extends "slurm.sh" %}
{% block header %}
module load lammps/3Aug2022
{% endblock header %}
{% block body %}
	{{- super () -}}
{% endblock body %}
