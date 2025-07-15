#!/bin/bash
#FLUX: --job-name=bricky-soup-6833
#FLUX: --priority=16

export OMP_NUM_THREADS='1'
export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/home/LUSTRE_SHARE/Packages/usr/lib64/nvidia'

module purge
module load cuda/8.0
export OMP_NUM_THREADS=1
module load lammps/2016/12/openmpi/1.10.3-3.el7/kokkos/omp_sw
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/LUSTRE_SHARE/Packages/usr/local/cuda-8.0/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/LUSTRE_SHARE/Packages/usr/lib64/nvidia
cd $SLURM_SUBMIT_DIR
mpirun -n $SLURM_NTASKS -wdir $SLURM_SUBMIT_DIR lammps  <input/RDX_lammps_MD.in> output/RDX_lammps_MD.out
