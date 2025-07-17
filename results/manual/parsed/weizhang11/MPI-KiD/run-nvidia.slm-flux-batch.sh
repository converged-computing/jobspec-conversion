#!/bin/bash
#FLUX: --job-name=psycho-ricecake-8886
#FLUX: --queue=ampere
#FLUX: -t=2400
#FLUX: --urgency=16

date
srun ./bin/KiD_CU_2D.exe namelists/CU_2D.nml output/CU_2D_nvidia_org.nc
ncdump -v mean_cloud_mass_path ./output/CU_2D_nvidia_org.nc
