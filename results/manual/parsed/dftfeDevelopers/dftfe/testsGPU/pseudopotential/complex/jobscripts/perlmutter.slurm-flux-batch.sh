#!/bin/bash
#FLUX: --job-name=complextests
#FLUX: --urgency=16

SLURM_CPU_BIND='cores'
OMP_NUM_THREADS=1
MPICH_GPU_SUPPORT_ENABLED=1
LD_LIBRARY_PATH = $LD_LIBRARY_PATH:$WD/env2/lib
LD_LIBRARY_PATH = $LD_LIBRARY_PATH:$WD/env2/lib64
module load nccl/2.15.5-ofi
srun ./dftfe parameterFileMg2x_1.prm > outputMg2x_1
srun ./dftfe parameterFileMg2x_2.prm > outputMg2x_2
srun ./dftfe parameterFileMg2x_3.prm > outputMg2x_3
srun ./dftfe parameterFileMg2x_4.prm > outputMg2x_4
srun ./dftfe parameterFileMg2x_5.prm > outputMg2x_5
srun ./dftfe parameterFileMg2x_6.prm > outputMg2x_6
srun -n 6 -c 1 ./dftfe parameterFileBe.prm > outputBe
