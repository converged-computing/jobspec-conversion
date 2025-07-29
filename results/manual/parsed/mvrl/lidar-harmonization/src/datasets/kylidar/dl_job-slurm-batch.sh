#!/bin/bash
#SBATCH --job-name=intensity_harmonization
#SBATCH --account=col_nja224_uksr
#SBATCH --output=lcc_run_log.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=01:00:00
#SBATCH --partition=CAL48M192_D

module purge
module load intel/19.0.4.243
module load impi/2019.4.243
module load ccs/singularity
CONTAINER=/pscratch/nja224_uksr/lidar_container
source /home/dtjo223/.bashrc
conda activate lidar
python ~/workspace/lidar-harmonization/src/dataset/kylidar/dl_kylidar.py
