#!/bin/bash
#FLUX: --job-name=clip-gpu-country
#FLUX: -c=16
#FLUX: --queue=red
#FLUX: -t=259199
#FLUX: --urgency=16

module load singularity
singularity run --nv --bind /home/data_shares/geocv:/home/data_shares/geocv /opt/itu/containers/pytorch/latest python src/ImbagClip.py separate 3
