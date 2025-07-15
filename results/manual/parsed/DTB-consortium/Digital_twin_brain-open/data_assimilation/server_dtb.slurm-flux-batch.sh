#!/bin/bash
#FLUX: --job-name=goodbye-peanut-butter-8360
#FLUX: --exclusive
#FLUX: --urgency=16

mkdir -p log/$SLURM_JOB_ID
mkdir -p log/$SLURM_JOB_ID/dmesg
mkdir -p log/$SLURM_JOB_ID/debug
mkdir -p log/$SLURM_JOB_ID/output
dmesg_log=log/$SLURM_JOB_ID/dmesg
debug_log=log/$SLURM_JOB_ID/debug
output_log=log/$SLURM_JOB_ID/output
hostfile_path=log/$SLURM_JOB_ID/hostfile
srun hostname |sort |uniq -c |awk '{if(NR==1){printf "%s slots=1\n",$2}else{printf "%s slots=4\n",$2}}' > ${hostfile_path}
module rm compiler/rocm/3.3
module rm compiler/rocm/2.9
module rm compiler/rocm/3.9
module rm compiler/rocm/3.5
module add compiler/cmake/3.15.6
module add compiler/rocm/4.0.1
date
mpirun --bind-to none --hostfile ${hostfile_path} --mca pml ucx --mca osc ucx \
       -x DMESG_LOG=${dmesg_log} \
       -x DEBUG_LOG=${debug_log} \
       -x OUTPUT_PATH=${output_log} \
       ../cuda/tools/dist_simulator.sh
date
