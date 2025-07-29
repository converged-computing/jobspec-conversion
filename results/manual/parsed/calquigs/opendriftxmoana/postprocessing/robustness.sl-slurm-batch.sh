#!/bin/bash
#FLUX: --job-name=robustness
#FLUX: -c=2
#FLUX: -t=900
#FLUX: --urgency=16

export SLURM_EXPORT_ENV='ALL'

export SLURM_EXPORT_ENV=ALL
module purge
files=(reinga_var/*)
file=${files[$SLURM_ARRAY_TASK_ID]}
module load Miniconda3
source activate opendrift_simon
python /nesi/project/vuw03073/opendriftxmoana/postprocessing/nparticle_robustness.py ${file}
