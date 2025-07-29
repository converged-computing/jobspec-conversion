#!/bin/bash
#SBATCH --job-name=data_sys
#SBATCH --account=ds_6050
#SBATCH --output=data_sys-%A.out
#SBATCH --error=data_sys-%A.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:rtx3090:2
#SBATCH --time=00:30:00

module purge
module load apptainer/1.2.2 pytorch/2.0.1 java/11 gcc/11.4.0 openmpi/4.1.4 python/3.11.4 spark/3.4.1
apptainer exec --nv $CONTAINERDIR/pytorch-2.0.1.sif Documents/MSDS/DS5110/Project/sdl_debugger.py 
