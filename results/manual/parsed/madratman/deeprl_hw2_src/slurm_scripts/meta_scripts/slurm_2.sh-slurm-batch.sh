#!/bin/bash
#SBATCH --output=log_2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:1
#SBATCH --mem=8192
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu
#SBATCH --nodelist=clamps

uname -a                                          # Display assigned cluster info
srun echo "I am on"
srun echo $HOSTNAME
srun echo "I got gpu number"
srun echo $CUDA_VISIBLE_DEVICES
srun nvidia-docker run --rm -e CUDA_VISIBLE_DEVICES=`echo $CUDA_VISIBLE_DEVICES` -v /data/datasets:/data/datasets -v /storage2/datasets:/storage2/datasets -v /local:/local -v /home/$USER:/home/$USER -v /storage1:/storage1 madratman/deeprl_hw /bin/bash -c /home/ratneshm/slurm_deeprl/meta_scripts/2.sh
