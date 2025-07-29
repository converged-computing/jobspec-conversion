#!/bin/bash
#SBATCH --job-name=segnet_unet
#SBATCH --mail-user=s317626@studenti.polito.it
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=100G
#SBATCH --time=4-20:00:00
#SBATCH --partition=cuda

module load intel/python/3/2019.4.088
module load nvidia/cudasdk/11.6
source /home/mla_group_02/visa/bin/activate
python /home/mla_group_02/visa/VISA/src/main.py
