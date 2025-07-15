#!/bin/bash
#FLUX: --job-name=info_flux
#FLUX: --queue=tier3
#FLUX: -t=18000
#FLUX: --priority=16

spack unload --all
spack load amber@20 /6r7gnm4
fileIDq=${1}
fileIDr=${2}
runsID=100
cpptraj -i atominfo_${fileIDq}_0.ctl | tee cpptraj_atominfo_${fileIDq}.txt
cpptraj -i atominfo_${fileIDr}_0.ctl | tee cpptraj_atominfo_${fileIDr}.txt
echo "Starting ${SLURM_ARRAY_TASK_ID}"
cpptraj -i atomflux_${fileIDq}_${SLURM_ARRAY_TASK_ID}.ctl | tee cpptraj_atomflux_${fileIDq}.txt
cpptraj -i atomflux_${fileIDr}_${SLURM_ARRAY_TASK_ID}.ctl | tee cpptraj_atomflux_${fileIDr}.txt
echo "Finished ${SLURM_ARRAY_TASK_ID}"
