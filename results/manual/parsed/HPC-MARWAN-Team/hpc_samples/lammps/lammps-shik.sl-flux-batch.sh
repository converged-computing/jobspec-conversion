#!/bin/bash
#FLUX: --job-name=placid-peanut-2978
#FLUX: -n=10
#FLUX: --queue=shortq
#FLUX: --priority=16

export WORK_DIR='/data/$USER/workdir/lammps/LMP${SLURM_JOB_ID}'
export INPUT_DIR='$PWD/Input'

module load intel2021/compiler/latest
module load blas/gcc/64/3.8.0
module load lapack/gcc/64/3.9.0
module load cmake-3.21.4-gcc-10.2.0-dwe6sfn
module load fftw3/openmpi/gcc/64/3.3.8
module load intel2021/mpi/latest
module load LAMMPS/28Mars2023
export WORK_DIR=/data/$USER/workdir/lammps/LMP${SLURM_JOB_ID}
export INPUT_DIR=$PWD/Input
mkdir -p $WORK_DIR
cp -R $INPUT_DIR/* $WORK_DIR
cd $WORK_DIR
echo "Work dir is   : $WORK_DIR"
mpirun -np $SLURM_NTASKS lmp -in in.NS 
echo "Done"
