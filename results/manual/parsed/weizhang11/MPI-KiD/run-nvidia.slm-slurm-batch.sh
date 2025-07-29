#!/bin/bash
#SBATCH --account=NWP501
#SBATCH --output=outnvidia.rpt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:40:00
#SBATCH --partition=ampere
#SBATCH --constraint=ntasks-per-node=128

date
srun ./bin/KiD_CU_2D.exe namelists/CU_2D.nml output/CU_2D_nvidia_org.nc
ncdump -v mean_cloud_mass_path ./output/CU_2D_nvidia_org.nc
