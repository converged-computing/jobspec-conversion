#!/bin/bash
#FLUX: --job-name=outstanding-destiny-2312
#FLUX: --urgency=16

export WANDB__SERVICE_WAIT='300'
export NCCL_DEBUG='INFO'

min_seed=1
max_seed=2
num_seeds=$(($max_seed - $min_seed + 1))
job_name="train_convnext"
output_file="${job_name}_%j.out"
error_file="${job_name}_%j.err"
partition="gpu"
nodes=1
gpus_per_node=2
tasks_per_node=2
timee="0-10:00:00"
cpu_per_task=12
source ~/miniconda3/etc/profile.d/conda.sh
conda activate pytorch_env
for i in $(seq $min_seed $max_seed); do
    # Set a random seed value
    seed=$RANDOM
    # Set the job name for this run
    run_num=$(printf "%02d" $i)
    seed_job_name="${job_name}_${run_num}"
    # Submit the Slurm job for this run
    sbatch --job-name=$seed_job_name --output=$output_file --error=$error_file \
           --nodes=$nodes --ntasks-per-node=$tasks_per_node --gres=gpu:$gpus_per_node \
           --time=$timee --partition=$partition --exclusive --cpus-per-task=$cpu_per_task \
            --mem=0 --gpus=$gpus_per_node \
           <<EOF
source ~/miniconda3/etc/profile.d/conda.sh
conda activate pytorch_env
nvidia-smi
export WANDB__SERVICE_WAIT=300
export NCCL_DEBUG=INFO
python train_convnext.py --seed $seed
EOF
done
conda deactivate
