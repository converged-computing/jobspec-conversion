#!/bin/bash
#FLUX: --job-name=grated-car-9044
#FLUX: --queue=ampere
#FLUX: -t=2400
#FLUX: --priority=16

date
srun ./bin/KiD_CU_2D.exe namelists/CU_2D.nml output/CU_2D_nvidia_org.nc
ncdump -v mean_cloud_mass_path ./output/CU_2D_nvidia_org.nc
