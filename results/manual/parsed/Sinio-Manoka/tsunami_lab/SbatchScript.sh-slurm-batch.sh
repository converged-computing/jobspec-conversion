#!/bin/bash
#SBATCH --job-name=tsunami
#SBATCH --output=tsunami_output.txt
#SBATCH --error=tsunami_error.txt
#SBATCH --mail-user=minawe.mohamad.khaled@uni-jena.de
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --time=03:00:00

   module load tools/python/3.8
   module load compiler/gcc/11.2.0
   module load compiler/intel/2020-Update2
   module load libs/hdf5/1.10.8-gcc-10.2.0
   module load libs/zlib/1.2.11-intel-2018
   module load libs/netcdf/4.6.1-intel-2018
   python3.8 -m pip install --user scons
   date
   cd /beegfs/go87vew/tsunami_lab
   scons
   OMP_NUM_THREADS=32 ./build/tsunami_lab
   OMP_NUM_THREADS=34 ./build/tsunami_lab
   OMP_NUM_THREADS=36 ./build/tsunami_lab
