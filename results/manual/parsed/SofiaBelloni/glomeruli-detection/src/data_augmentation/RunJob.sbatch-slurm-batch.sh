#!/bin/bash
#SBATCH --job-name=data_augmentation
#SBATCH --mail-user=s317626@studenti.polito.it
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=50G
#SBATCH --time=05:00:00

module load intel/python/3/2019.4.088
module load nvidia/cudasdk/11.6
source /home/mla_group_02/visa/bin/activate
python /home/mla_group_02/visa/VISA/src/data_augmentation/main_crop.py
