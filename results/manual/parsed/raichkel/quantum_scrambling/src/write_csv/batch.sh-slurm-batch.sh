#!/bin/bash
#FLUX: --job-name=write_csv
#FLUX: --queue=QuamNESS
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load lang/julia/1.8.5
cd "${SLURM_SUBMIT_DIR}"
echo "Running on host $(hostname)"
echo "Started on $(date)"
echo "Directory is $(pwd)"
echo "Slurm job ID is ${SLURM_JOBID}"
echo "This jobs runs on the following machines:"
echo "${SLURM_JOB_NODELIST}" 
printf "\n\n"
julia tdvp.jl 80.0 21 "MF" 1.0 1.0 1.0 1.0 1.0 1.0
printf "\n\n"
echo "Ended on: $(date)"
