#!/bin/bash
#SBATCH --job-name=foveation
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem=40GB
#SBATCH --time=10:00:00
#SBATCH --partition=cbmm
#SBATCH --qos=cbmm
#SBATCH --array=0-999

hostname
module add openmind/singularity/3.4.1
arrayexperiments=(0 1000 2000 3000 4000 5000)
for i in "${arrayexperiments[@]}"
do
singularity exec -B /om:/om --nv /om/user/xboix/singularity/xboix-tensorflow-vanessa.simg \
python /om/user/vanessad/IMDb_framework/main.py \
--host_filesystem om \
--experiment_index ${SLURM_ARRAY_TASK_ID} \
--offset_index $i \
--run train \
--repetition_folder_path 0
done
