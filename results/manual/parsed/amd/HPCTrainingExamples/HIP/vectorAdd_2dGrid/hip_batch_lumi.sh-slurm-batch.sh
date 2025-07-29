#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=1
#SBATCH --time=00:10:00
#SBATCH --partition=small-g

export HCC_AMDGPU_TARGET='`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'`'

module reset
module load craype-accel-amd-gfx90a
module load rocm
cd $HOME/HPCTrainingExamples/HIP/vectorAdd
export HCC_AMDGPU_TARGET=`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'`
make vectoradd
srun ./vectoradd
