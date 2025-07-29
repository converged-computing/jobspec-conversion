#!/bin/bash
#SBATCH --job-name=convert_laz_np
#SBATCH --account=col_nja224_uksr
#SBATCH --output=laz_to_np_log.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=01:00:00
#SBATCH --partition=SAN32M512_L

module purge
module load intel/19.0.4.243
module load impi/2019.4.243
module load ccs/singularity
CONTAINER=/psratch/nja224_uksr/lidar_container
source /home/dtjo223/.bashrc
conda activate lidar
python $PSCRATCH/nja224_uksr/dtjo223/lidar-harmonization/src/datasets/tools/laz_to_numpy.py
