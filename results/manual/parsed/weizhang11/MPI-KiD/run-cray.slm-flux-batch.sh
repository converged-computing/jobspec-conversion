#!/bin/bash
#FLUX: --job-name=casim1
#FLUX: -t=7200
#FLUX: --priority=16

date
ulimit -s unlimited
ulimit -v unlimited
srun ./bin/KiD_CU_2D.exe namelists/CU_2D.nml output/CU_2D_cray_1.nc
ncdump -v mean_cloud_mass_path ./output/CU_2D_cray_1.nc > cloudmass.txt
