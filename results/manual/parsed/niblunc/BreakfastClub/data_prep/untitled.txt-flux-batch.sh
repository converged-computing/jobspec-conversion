#!/bin/bash
#FLUX: --job-name=BCLUB_FPREP
#FLUX: -t=86400
#FLUX: --urgency=16

if [ ${SLURM_ARRAY_TASK_ID} -lt 10 ]; then
    sub="sub-00${SLURM_ARRAY_TASK_ID}"
else
    sub="sub-0${SLURM_ARRAY_TASK_ID}"
fi
singularity exec -B /:/home_dir /projects/niblab/bids_projects/Singularity_Containers/fmriprep.simg fmriprep /home_dir/projects/niblab/bids_projects/Experiments/BreakfastClub/BID$
    participant  \
    --participant-label $sub \
    --fs-license-file /home_dir/projects/niblab/bids_projects/freesurfer/license.txt \
    --longitudinal \
    --fs-no-reconall \
    --omp-nthreads 16 --n_cpus 16  \
    --bold2t1w-dof 12 \
    --output-space template --template MNI152NLin2009cAsym \
    -w /home_dir/projects/niblab/bids_projects/Experiments/BreakfastClub/fmriprep/${sub}/ses-1 \
    --debug  \
