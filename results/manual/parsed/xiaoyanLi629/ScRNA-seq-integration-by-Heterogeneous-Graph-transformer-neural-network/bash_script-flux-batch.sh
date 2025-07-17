#!/bin/bash
#FLUX: --job-name=scRNA_seq_inte
#FLUX: -c=2
#FLUX: -t=18000
#FLUX: --urgency=16

module purge
module load GCCcore/10.3.0
conda activate env_
python -u node_feature.py > output.txt
scontrol show job $SLURM_JOB_ID           ### write job information to output file
js -j $SLURM_JOB_ID 
