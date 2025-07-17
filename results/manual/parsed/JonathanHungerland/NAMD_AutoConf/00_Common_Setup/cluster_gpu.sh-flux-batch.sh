#!/bin/bash
#FLUX: --job-name=faux-egg-6214
#FLUX: --queue=qblg.p
#FLUX: -t=345600
#FLUX: --urgency=16

export NTASKS='$(( ${SLURM_NNODES} * ${SLURM_NTASKS_PER_NODE} ))'
export namdexecution='namd3 +p${NTASKS}'
export namd3gpu_execution='namd3 +idlepoll +p${NTASKS} +devices 0'

scontrol update jobid=${SLURM_JOB_ID} jobname=$1
module load hpc-env/12.2 NAMD/3.0b4-multicore-CUDA
export NTASKS=$(( ${SLURM_NNODES} * ${SLURM_NTASKS_PER_NODE} ))
export namdexecution="namd3 +p${NTASKS}"
export namd3gpu_execution="namd3 +idlepoll +p${NTASKS} +devices 0"
source $1
echo "Starting NAMD run."
${MAINDIR}/02_Simulation_Setup/00_generate_setup.sh $1
