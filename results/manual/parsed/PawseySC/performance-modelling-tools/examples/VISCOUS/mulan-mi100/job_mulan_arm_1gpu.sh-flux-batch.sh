#!/bin/bash
#FLUX: --job-name=lmp_benchm
#FLUX: -c=32
#FLUX: -t=3600
#FLUX: --urgency=16

export LIBRARY_PATH='/opt/rocm-4.5.0/hipfft/lib:$LIBRARY_PATH'
export LD_LIBRARY_PATH='/opt/rocm-4.5.0/hipfft/lib:$LD_LIBRARY_PATH'
export CPATH='/opt/rocm-4.5.0/hipfft/include:$CPATH'
export ALLINEA_CONFIG_DIR='$HOME/.allinea_mulan'
export SLURM_OVERLAP='1'
export MPICC='cc'
export OMP_NUM_THREADS='1'

module unload gcc/9.3.0
module load craype-accel-amd-gfx908
module load rocm/4.5.0
export LIBRARY_PATH="/opt/rocm-4.5.0/hipfft/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="/opt/rocm-4.5.0/hipfft/lib:$LD_LIBRARY_PATH"
export CPATH="/opt/rocm-4.5.0/hipfft/include:$CPATH"
lmp_dir="<installation-dir>" ### EDIT ME ###
lmp="$lmp_dir/lammps/src/lmp_mulan_mi100"
. /pawsey/mulan/bin/init-forge-21.1.sh
export ALLINEA_CONFIG_DIR="$HOME/.allinea_mulan"
export SLURM_OVERLAP=1
export MPICC=cc
NUM_GPUS=1
echo using executable "$lmp"
echo using $SLURM_JOB_NUM_NODES nodes
echo using $SLURM_NTASKS tasks
echo using $NUM_GPUS GPUs per node
export OMP_NUM_THREADS=1
echo starting lammps at $(date)
map --profile \
  srun $lmp -sf kk -k on g $NUM_GPUS -in lammps.inp -log lammps.out
echo finishing lammps at $(date)
exit
