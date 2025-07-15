#!/bin/bash
#FLUX: --job-name=scruptious-fork-2191
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='~/.conda/envs/sca_env/lib:$LD_LIBRARY_PATH'
export PATH='~/.conda/envs/sca_env/bin:$PATH'
export OMP_NUM_THREADS='1'

. /etc/profile.d/modules.sh                # Leave this line (enables the module command)
module purge                               # Removes all modules still loaded
module load rhel8/default-amp              # REQUIRED - loads the basic environment
module avail nvidia-cuda-toolkit
export LD_LIBRARY_PATH=~/.conda/envs/sca_env/lib:$LD_LIBRARY_PATH
export PATH=~/.conda/envs/sca_env/bin:$PATH
source /home/${USER}/.bashrc
conda activate sca_env
export OMP_NUM_THREADS=1
config=/rds/user/ar2217/hpc-work/SCA/SCA_project/cluster_launch/sca_params.txt
d=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $2}' $config)
dataset_path=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $3}' $config)
save_path=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $4}' $config)
seed=$(awk -v ArrayTaskID=$SLURM_ARRAY_TASK_ID '$1==ArrayTaskID {print $5}' $config)
python /rds/user/ar2217/hpc-work/SCA/SCA_project/MC_Maze_linear_SCA.py --d $d --dataset_path $dataset_path --save_path $save_path --seed $seed 
