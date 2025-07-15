#!/bin/bash
#FLUX: --job-name=purple-motorcycle-3101
#FLUX: --queue=gpu
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
module load nvidia/cuda/10.1
module load intel/parallelstudio/2017u8
/project/chenyongtin/tools/anaconda3/envs/deepmd-kit/bin/lmp -i in.lammps >lmp.out
