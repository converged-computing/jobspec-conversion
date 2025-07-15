#!/bin/bash
#FLUX: --job-name=sac
#FLUX: -c=4
#FLUX: --queue=savio3_gpu
#FLUX: -t=86400
#FLUX: --priority=16

ENV_ID=$((SLURM_ARRAY_TASK_ID-1))
arrENVS=(${ENVS//;/ })
ENV_NAME=${arrENVS[$ENV_ID]}
module load gnu-parallel
echo $ENV_NAME
run_singularity ()
{
    singularity exec --nv --writable-tmpfs -B /usr/lib64 -B /var/lib/dcv-gl --overlay $SCRATCH/singularity/overlay-50G-10M.ext3:ro $SCRATCH/singularity/cuda11.5-cudnn8-devel-ubuntu18.04.sif /bin/bash -c "
    source ~/.bashrc
    XLA_PYTHON_CLIENT_PREALLOCATE=false python ../examples/train_online.py --env_name=$2 \
                    --seed=$1 \
                    --save_dir=logs/results/sac_target/$2/ \
                    --config=../examples/configs/sac_default.py \
                    --use_actor_target \
                    --notqdm
    "
}
export -f run_singularity
parallel --delay 20 --linebuffer -j 4 run_singularity {} $ENV_NAME ::: 1 2 3 4 5 6 7 8 9 10
