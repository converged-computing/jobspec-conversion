#!/bin/bash
#FLUX: --job-name=strawberry-malarkey-7768
#FLUX: -t=10800
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/lib'

module load miniconda3/gpu/4.9.2
conda activate nipype
module load fsl/.6.0.6
export LD_LIBRARY_PATH=/lib
module load ants/2.1.0
module load freesurfer/7.4.1
subj_list=$(cut -f1 subjectsfile.txt)
subj_list=($subj_list)
subj_num=$(($SLURM_ARRAY_TASK_ID-1))
subj=${subj_list[$subj_num]}
python3 fmap_corr.py $subj
