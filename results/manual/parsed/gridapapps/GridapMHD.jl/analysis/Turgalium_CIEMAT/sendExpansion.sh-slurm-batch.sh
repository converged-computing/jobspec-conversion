#!/bin/bash
#SBATCH --job-name=Exp_Ha50_ser
#SBATCH --output=outputExp_Ha50_ser
#SBATCH --error=errorExp_Ha50_ser
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=0
#SBATCH --time=1-00:00:00
#SBATCH --partition=volta
#SBATCH --constraint=ntasks-per-node=1

SLURM_NPROCS=`expr $SLURM_JOB_NUM_NODES \* $SLURM_NTASKS_PER_NODE`
srun hostname -s > hosts.$SLURM_JOB_ID
echo "================================================================"
hostname
echo "Using: ${SLURM_NPROCS} procs in ${SLURM_JOB_NUM_NODES} nodes"
echo "================================================================"
echo ""
SECONDS=0
source env.sh
mpiexec -n ${SLURM_NPROCS} julia --project=$GRIDAPMHD -J $GRIDAPMHD/compile/Turgalium_CIEMAT/GridapMHD36c.so -O3 --check-bounds=no -e\
'
using GridapMHD: expansion
expansion(;
  mesh="68k", 
  np=2,
  backend=:mpi,
  Ha = 50.0,
  N = 3740.0,
  cw = 0.01,
  debug=false,
  vtk=true,
  title="Expansion_Ha50_serial",
  solver=:julia,
 )'
duration=$SECONDS
rm -f hosts.$SLURM_JOB_ID
STATUS=$?
echo "================================================================"
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
echo "================================================================"
echo ""
echo "STATUS = $STATUS"
echo ""
