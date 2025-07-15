#!/bin/bash
#FLUX: --job-name="Team 1 - GANSpace"
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export NUM_THREADS='$SLURM_CPUS_PER_TASK'

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export NUM_THREADS=$SLURM_CPUS_PER_TASK
module purge
module load gnu/8 cuda/10.1.168 pytorch/1.8.0
source /users/pa19/gealexdl/team1/venv/bin/activate
declare -a layers=("style"  "to_rgb1"  "input"  "conv"  "conv1.conv" "convs"  "to_rgbs.0.upsample" "to_rgbs.0.conv" "to_rgbs.0.conv.modulation")
declare -a classes=("car" "kitchen" "places")
for layer in "${layers[@]}" 
do 
    for class in "${classes[@]}"
    do
        srun python3 /users/pa19/gealexdl/team1/ganspace/visualize.py  --model StyleGAN2 --est pca --class "$class" --use_w --layer "$layer" -c 20 --sigma 3
    done
done
deactivate
