#!/bin/bash
#FLUX --job-name=muffled-poo-6727
#FLUX -c=4
#FLUX -t=28800
#FLUX --urgency=16

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/monailabel/ docker://projectmonai/monailabel:latest
