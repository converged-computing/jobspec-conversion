#!/bin/bash
#FLUX: --job-name=run_exp
#FLUX: -c=8
#FLUX: -t=18000
#FLUX: --urgency=16

singularity exec --nv --overlay /scratch/bne215/overlay-50G-10M.ext3:ro \
    --overlay /scratch/work/public/singularity/mujoco200-dep-cuda11.1-cudnn8-ubunutu18.04.sqf:ro \
    /scratch/work/public/singularity/cuda11.1-cudnn8-devel-ubuntu18.04.sif /bin/bash -c "
source /ext3/env.sh
conda activate
python run_exp.py -c da_configs/greene/slidepuck/continuous/slidepuck_continuous_0.yaml
"
