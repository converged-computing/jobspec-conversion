#!/bin/bash
#FLUX: --job-name=nerdy-pot-6903
#FLUX: -N=2
#FLUX: -c=24
#FLUX: --queue=gpus
#FLUX: -t=300
#FLUX: --urgency=16

export OMP_NUM_THREADS='24'

module load Python/3.8.5
module load GCC/9.3.0
module load OpenMPI/4.1.0rc1
module load CUDA/11.3
module load Nsight-Systems/2021.1.1
module load Nsight-Compute/2020.3.0
module load ParaStationMPI/5.4.7-1
module load mpi-settings/CUDA
module load GCCcore/.10.3.0
module load GCCcore/.9.3.0
module load GSL/2.6 
export OMP_NUM_THREADS=24
src=$1
w1=785
w2=798
time srun $src/sca_formod cloud-${w1}-${w2}.ctl obs33.tab atm.tab submissions/rad-${2}.tab AEROFILE aero.tab DIRLIST aux/first_004
module load Stages/2020
module load GCC/10.3.0  OpenMPI/4.1.1 Valgrind/3.17.0
module load Python/3.8.5
module load GCC/9.3.0
module load OpenMPI/4.1.0rc1
module load CUDA/11.3
module load Nsight-Systems/2021.1.1
module load Nsight-Compute/2020.3.0
module load ParaStationMPI/5.4.7-1
module load mpi-settings/CUDA
module load GCCcore/.10.3.0
module load GCCcore/.9.3.0
module load GSL/2.6 
module load GDB/10.1 
