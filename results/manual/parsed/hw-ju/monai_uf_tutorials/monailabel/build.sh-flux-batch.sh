#!/bin/bash
#FLUX: --job-name=gloopy-cherry-1289
#FLUX: -c=4
#FLUX: -t=28800
#FLUX: --urgency=16

date;hostname;pwd
module load singularity
singularity build --sandbox /blue/vendor-nvidia/hju/monailabel/ docker://projectmonai/monailabel:latest
