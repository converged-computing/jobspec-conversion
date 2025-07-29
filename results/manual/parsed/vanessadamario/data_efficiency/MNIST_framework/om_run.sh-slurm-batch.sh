#!/bin/bash
#SBATCH --job-name=new_exp1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem=25GB
#SBATCH --time=1-01:00:00
#SBATCH --partition=normal
#SBATCH --chdir=/om/user/vanessad/MNIST_framework/
#SBATCH --array=0-399

module add openmind/singularity/3.4.1
offset_array=(11088 11488 11888 12288 12688)
repetition=("MNIST_std_repetition_0" "MNIST_std_repetition_1")
for j in "${repetition[@]}"
do
  for i in "${offset_array[@]}"
  do
    singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow2.simg \
      python /om/user/vanessad/MNIST_framework/main.py \
      --host_filesystem om \
      --experiment_index ${SLURM_ARRAY_TASK_ID} \
      --offset_index $i \
      --run train \
      --repetition_folder_path $j
  done
done
