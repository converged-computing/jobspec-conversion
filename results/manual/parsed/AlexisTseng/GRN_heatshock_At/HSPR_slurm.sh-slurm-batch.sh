#!/bin/bash
#SBATCH --job-name=hsGRN_Gillespie
#SBATCH --account=LOCKE-SL3-CPU
#SBATCH --output=/home/jz531/rds/hpc-work/hpc_output/Gilespie_output.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=5980MB
#SBATCH --time=12:00:00
#SBATCH --chdir=/home/jz531/rds/hpc-work/GRN_heatshock_At/
#SBATCH --no-requeue
#SBATCH --array=500

. /etc/profile.d/modules.sh # Leave this line (enables the module command)
module purge  # Removes all modules still loaded
source /home/jz531/.bashrc # need to source before conda activate
conda activate model_GRN
CMD="python3 HSPR_AZ_hpc.py -nit 5 -ids "159.461275414781" -psd 0 -hsd 1 -tsp 600 -hss 400"
eval $CMD
