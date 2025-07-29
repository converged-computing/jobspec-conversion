#!/bin/bash
#SBATCH --job-name=MOM6
#SBATCH --account=cimes2
#SBATCH --mail-user=cheng.zhang@princeton.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=512000M
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/lib64:/home/cz3321/torch_gpu/lib'

rm -rf *.nc
module purge
module load anaconda3/2021.5 intel/2021.1.2 openmpi/intel-2021.1/4.1.0 hdf5/intel-2021.1/1.10.6 netcdf/intel-19.1/hdf5-1.10.6/4.7.4 cudatoolkit/11.3 
source activate ~/torch_gpu
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/lib64:/home/cz3321/torch_gpu/lib
srun -n 16 ../../../build/intel/ocean_only/repro/MOM6
