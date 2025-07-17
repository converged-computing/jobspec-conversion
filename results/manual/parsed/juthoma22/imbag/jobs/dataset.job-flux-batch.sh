#!/bin/bash
#FLUX: --job-name=datasets
#FLUX: -c=16
#FLUX: --queue=red
#FLUX: -t=86340
#FLUX: --urgency=16

module load singularity
singularity run --nv --bind /home/data_shares/geocv:/home/data_shares/geocv /opt/itu/containers/pytorch/latest python3 src/create_datasets.py
