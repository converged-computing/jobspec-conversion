#!/bin/bash
#FLUX: --job-name={Sim_Name}
#FLUX: --queue=gpu
#FLUX: --urgency=16

cd {path}
module unload mvapich2_ib
module unload intel
module load intel/2015.2.164
module load mvapich2_ib
module load cuda
ibrun -np 8 /share/apps/gpu/lammps/lmp_cuda_mpi -sf gpu -pk gpu 4 -in in.{Sim_Name} -log log.{Sim_Name}
