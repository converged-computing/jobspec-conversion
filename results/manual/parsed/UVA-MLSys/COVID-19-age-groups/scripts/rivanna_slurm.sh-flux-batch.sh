#!/bin/bash
#FLUX: --job-name=Crossformer_train_total
#FLUX: --queue=gpu
#FLUX: -t=43200
#FLUX: --urgency=16

source /etc/profile.d/modules.sh
source ~/.bashrc
module load singularity
singularity run --nv timeseries.sif python run.py --data_path Total.csv --model Crossformer
