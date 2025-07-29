#!/bin/bash
#FLUX --job-name=moolicious-taco-7486
#FLUX --queue=compute
#FLUX -t=300
#FLUX --urgency=16

export APPTAINERENV_NEWHOME='$(pwd)'

module load apptainer
export APPTAINERENV_NEWHOME=$(pwd)
apptainer build apptainerSif.sif docker://nlsschim/pytrackmate
