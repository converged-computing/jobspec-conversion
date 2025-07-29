#!/bin/bash
#FLUX: --job-name=waom10_shflim_S
#FLUX: -N=7
#FLUX: -n=256
#FLUX: --queue=large
#FLUX: -t=259200
#FLUX: --urgency=16

module purge
module load intel-oneapi-compilers-classic/2021.6.0 intel-oneapi-mpi/2021.6.0 intel-oneapi-mkl/2022.1.0
module load cmake
module load netcdf-c/4.8.1
module load netcdf-fortran/4.5.4
srun /scratch/project_2000789/muramarg/ROMSIceShelfFISOC/ROMS/oceanG /scratch/project_2000789/muramarg/ROMSIceShelfFISOC/ROMS/External/ocean_waom10_test.in > /scratch/project_2000789/muramarg/waom_test/output_WAOM_check/ocean.log
