#!/bin/bash
#FLUX: --job-name=BEVEL_BIDS
#FLUX: --priority=16

if [ ${SLURM_ARRAY_TASK_ID} -lt 10 ]; then
    sub="sub-00${SLURM_ARRAY_TASK_ID}"
else
    sub="sub-0${SLURM_ARRAY_TASK_ID}"
fi
singularity exec -B /:/base_dir /projects/niblab/bids_projects/Singularity_Containers/heudiconv_05_2019.simg \
heudiconv -b -d /base_dir/projects/niblab/bids_projects/Experiments/Bevel/DICOMS/sub-{subject}/*dcm -s sub \
-f /base_dir/projects/niblab/bids_projects/Experiments/Bevel/BIDS/code/bevel_heuristic.py \
-c dcm2niix -o /base_dir/projects/niblab/bids_projects/Experiments/Bevel/BIDS
