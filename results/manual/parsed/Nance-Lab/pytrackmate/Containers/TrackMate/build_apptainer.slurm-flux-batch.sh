#!/bin/bash
#FLUX: --job-name=angry-lemon-3740
#FLUX: -t=300
#FLUX: --priority=16

export APPTAINERENV_NEWHOME='$(pwd)'

module load apptainer
export APPTAINERENV_NEWHOME=$(pwd)
apptainer build apptainerSif.sif docker://nlsschim/pytrackmate
