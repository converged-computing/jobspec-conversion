#!/bin/bash
#FLUX: --job-name=crr
#FLUX: -t=10800
#FLUX: --priority=16

modes=("expert" "mixed-const" "mixed-exp")
mode=${modes[${SLURM_ARRAY_TASK_ID}]}
singularity exec \
    --overlay /scratch/nv2099/images/overlay-50G-10M.ext3:ro \
    /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
    /bin/bash -c "
    source /ext3/miniconda3/etc/profile.d/conda.sh;
    conda activate mcs;
    cd /home/nv2099/projects/mcs/csv_obs;
    python -u leduc_crr.py --traj trajectories/traj-${mode}--1e+06.csv --label ${mode};
    "
