#!/bin/bash
#FLUX: --job-name=pull_images
#FLUX: -t=21600
#FLUX: --priority=16

singularity exec docker://quay.io/biocontainers/blast:2.9.0--pl526h3066fca_4 echo ciao
singularity exec docker://rocker/tidyverse:3.6.1 echo ciao
singularity exec docker://jupyter/datascience-notebook:latest echo ciao
singularity exec library://marcodelapierre/beta/openfoam:v2012 echo ciao
singularity exec docker://nvcr.io/hpc/gromacs:2018.2 echo ciao
singularity exec docker://trinityrnaseq/trinityrnaseq:2.8.6 echo ciao
singularity exec docker://nextflow/rnaseq-nf:latest echo ciao
singularity exec docker://marcodelapierre/gnuplot:5.2.2_4 echo ciao
