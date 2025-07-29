#!/bin/bash
#SBATCH --account=imi@gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --qos=qos_gpu-t3
#SBATCH --array=0-278%100

export SLURM_ARRAY_TASK_ID='$(($SLURM_ARRAY_TASK_ID+1))'
export index='$i'

module load pytorch-gpu/py3/1.8.0
exp=$1
i=$2
export SLURM_ARRAY_TASK_ID=$(($SLURM_ARRAY_TASK_ID+1))
line=$(sed "${SLURM_ARRAY_TASK_ID}q;d" base_filenames_test.txt)
export index=$i
seed=$(shuf -n 1 $SCRATCH/data/seeds_${index})
./script_generate.sh $exp $line --generate_bvh --data_dir $SCRATCH/data/dance_combined_test${i} --output_folder=inference/generated_${i} --seeds expmap_scaled_20,$seed
