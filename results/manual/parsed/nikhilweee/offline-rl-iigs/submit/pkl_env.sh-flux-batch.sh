#!/bin/bash
#FLUX: --job-name=pkl_env
#FLUX: -t=3600
#FLUX: --urgency=16

echo "Starting SLURM Script"
nums=("000" "010" "025" "050" "100")
num=${nums[${SLURM_ARRAY_TASK_ID}]}
singularity exec --nv \
    --overlay /scratch/nv2099/images/overlay-50G-10M.ext3:ro \
    /scratch/work/public/singularity/cuda11.3.0-cudnn8-devel-ubuntu20.04.sif \
    /bin/bash -c "
    source /ext3/miniconda3/etc/profile.d/conda.sh;
    conda activate spiel;
    cd /home/nv2099/projects/mcs/pkl_obs;
    python -u env.py --model rnn --train_traj trajectories/traj-${num}-*.pkl --label ${num};
    "
echo "Finishing SLURM Script"
