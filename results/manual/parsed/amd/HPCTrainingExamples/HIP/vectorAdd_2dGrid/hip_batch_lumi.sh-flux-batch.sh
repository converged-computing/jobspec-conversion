#!/bin/bash
#FLUX: --job-name=dirty-destiny-1076
#FLUX: --urgency=16

export HCC_AMDGPU_TARGET='`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'`'

module reset
module load craype-accel-amd-gfx90a
module load rocm
cd $HOME/HPCTrainingExamples/HIP/vectorAdd
export HCC_AMDGPU_TARGET=`rocminfo |grep -m 1 -E gfx[^0]{1} | sed -e 's/ *Name: *\(gfx[0-9,a-f]*\) *$/\1/'`
make vectoradd
srun ./vectoradd
