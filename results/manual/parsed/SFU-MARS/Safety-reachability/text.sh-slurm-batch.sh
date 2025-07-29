#!/bin/bash
#SBATCH --job-name=tt
#SBATCH --output=%N-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=7-00:00:00
#SBATCH --qos=overcap
#SBATCH --nodelist=cs-venus-01

source ~/miniconda3/etc/profile.d/conda.sh
conda activate wpnr
hostname
echo $CUDA_AVAILABLE_DEVICES
srun python -u /local-scratch/tara/project/WayPtNav-reachability/executables/rgb/resnet50/rgb_waypoint_trainer.py --job-dir=/local-scratch/tara/project/WayPtNav-reachability/log/train --params=/local-scratch/tara/project/WayPtNav-reachability/params/rgb_trainer/sbpd/projected_grid/resnet50/rgb_waypoint_trainer_finetune_params.py --device=0
