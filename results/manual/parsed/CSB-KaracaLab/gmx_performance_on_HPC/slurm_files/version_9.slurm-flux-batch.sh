#!/bin/bash
#FLUX: --job-name=eccentric-cherry-2508
#FLUX: -t=86400
#FLUX: --priority=16

export OMP_NUM_THREADS='20'

source /etc/profile.d/modules.sh
module load centos7.3/app/gromacs/2020-impi-mkl-PS2018-GOLD-CUDA
module load  centos7.3/lib/cuda/10.0
export CUDA_VISIBLE_DEVICES
module load centos7.3/lib/acml/6.1.0-gfortan64
export OMP_NUM_THREADS=20
echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"
$GROMACS_DIR/bin/gmx_mpi mdrun -v -deffnm complex_md -pin on -gputasks 01 -nb gpu -pme gpu
exit
