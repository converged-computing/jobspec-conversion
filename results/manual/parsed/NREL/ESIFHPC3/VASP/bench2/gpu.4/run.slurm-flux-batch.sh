#!/bin/bash
#FLUX: --job-name=gb2.4
#FLUX: -N=4
#FLUX: -t=14400
#FLUX: --urgency=16

module purge
module use /nopt/nrel/apps/modules/centos74/modulefiles/
module load intel-mpi/2018.0.3 mkl/2018.3.222 cuda/10.2.89 
module list
input_path=../input
vasp_run=/projects/nafion/openmp/vasp6/dist3/vasp.6.1.2/bin/vasp_gpu
cp $input_path/INCAR  .
cp $input_path/KPOINTS .
cp $input_path/POSCAR .
cp $input_path/POTCAR .
nnodes=$SLURM_NNODES
rankspernode=8
ntasks=$((nnodes*rankspernode))
time srun --ntasks=$ntasks --tasks-per-node=$rankspernode $vasp_run >& LOG
