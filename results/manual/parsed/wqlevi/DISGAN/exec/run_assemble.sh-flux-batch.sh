#!/bin/bash
#FLUX: --job-name=fugly-hobbit-6068
#FLUX: -t=1800
#FLUX: --urgency=16

module purge 
module load anaconda/3/2020.02
module load nibabel/2.5.0
srun python /u/wangqi/torch_env/crop_gan/assemble_crop_v3.py --path /ptmp/wangqi/MPI_subj3/gen_data --subj MPRAGE --scale 2
echo "Jobs finished"
