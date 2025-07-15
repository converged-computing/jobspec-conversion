#!/bin/bash
#FLUX: --job-name=Hunt_mumps_500
#FLUX: --queue=cpu36c
#FLUX: --urgency=16

SLURM_NPROCS=`expr $SLURM_JOB_NUM_NODES \* $SLURM_NTASKS_PER_NODE`
srun hostname -s > hosts.$SLURM_JOB_ID
echo "================================================================"
hostname
echo "Using: ${SLURM_NPROCS} procs in ${SLURM_JOB_NUM_NODES} nodes"
echo "================================================================"
echo ""
SECONDS=0
source env.sh
julia --project=$GRIDAPMHD -J $GRIDAPMHD/compile/Turgalium_CIEMAT/GridapMHD36c.so -O3 --check-bounds=no -e\
'
using GridapMHD: hunt
hunt(
  nc=(50,50),
  L=1.0,
  B=(0.,500.,0.),
  nsums = 1000,
  debug=false,
  vtk=true,
  title="hunt_500_petsc_n1",
  mesh = false,
  BL_adapted = true,
  solver=:petsc,
  petsc_options="-snes_monitor -ksp_error_if_not_converged true -ksp_converged_reason -ksp_type preonly -pc_type lu -pc_factor_mat_solver_type mumps",
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
