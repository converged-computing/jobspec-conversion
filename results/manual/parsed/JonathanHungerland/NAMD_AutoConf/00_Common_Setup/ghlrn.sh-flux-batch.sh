#!/bin/bash
#FLUX: --job-name=lovely-lemur-2910
#FLUX: -N=2
#FLUX: --queue=standard96
#FLUX: -t=43200
#FLUX: --urgency=16

export SLURM_CPU_BIND='none'
export NTASKS='$(( ${SLURM_NNODES} * ${SLURM_NTASKS_PER_NODE} ))'
export namdexecution='mpirun namd2'
export replicaexecution='mpirun namd2'
export sortreplicas='$( which sortreplicas )'

scontrol update jobid=${SLURM_JOB_ID} jobname=$1
module purge
module load HLRNenv
module load vmd
export SLURM_CPU_BIND=none
module load impi
module load namd/2.13
export NTASKS=$(( ${SLURM_NNODES} * ${SLURM_NTASKS_PER_NODE} ))
export namdexecution="mpirun namd2"
export replicaexecution="mpirun namd2"
export sortreplicas=$( which sortreplicas )
source $1
echo "Starting NAMD run."
${MAINDIR}/02_Simulation_Setup/00_generate_setup.sh $1
