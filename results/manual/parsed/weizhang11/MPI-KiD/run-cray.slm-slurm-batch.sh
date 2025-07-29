#!/bin/bash
#SBATCH --job-name=casim1
#SBATCH --account=NWP501
#SBATCH --output=outcray.rpt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=32

date
ulimit -s unlimited
ulimit -v unlimited
srun ./bin/KiD_CU_2D.exe namelists/CU_2D.nml output/CU_2D_cray_1.nc
ncdump -v mean_cloud_mass_path ./output/CU_2D_cray_1.nc > cloudmass.txt
