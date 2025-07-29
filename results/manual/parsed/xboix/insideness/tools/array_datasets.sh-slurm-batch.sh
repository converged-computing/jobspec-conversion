#!/bin/bash
#SBATCH --job-name=insideness
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:tesla-k80:1
#SBATCH --mem-per-cpu=16GB
#SBATCH --time=4-04:00:00
#SBATCH --qos=cbmm
#SBATCH --chdir=./log/
#SBATCH --array=51

cd /om/user/xboix/src/insideness/
/om2/user/jakubk/miniconda3/envs/torch/bin/python -c 'import torch; print(torch.rand(2,3).cuda())'
singularity exec -B /om:/om  --nv /om/user/xboix/singularity/xboix-tensorflow.simg \
python /om/user/xboix/src/insideness/main.py \
--experiment_index=${SLURM_ARRAY_TASK_ID} \
--host_filesystem=om \
--run=generate_dataset \
--network=crossing
