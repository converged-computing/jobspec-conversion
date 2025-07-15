#!/bin/bash
#FLUX: --job-name=Exp_Ha50_ser
#FLUX: --queue=volta
#FLUX: --priority=16

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
