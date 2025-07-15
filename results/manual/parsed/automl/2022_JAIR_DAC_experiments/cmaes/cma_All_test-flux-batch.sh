#!/bin/bash
#FLUX: --job-name=creamy-avocado-4078
#FLUX: --urgency=16

export TF_XLA_FLAGS='--tf_xla_cpu_global_jit'

source ~/.bashrc
conda activate dacbench
echo "Workingdir: $PWD";
echo "Started at $(date)";
echo "Running job $SLURM_JOB_NAME using $SLURM_JOB_CPUS_PER_NODE cpus per node with given JID $SLURM_JOB_ID on queue $SLURM_JOB_PARTITION"; 
export TF_XLA_FLAGS=--tf_xla_cpu_global_jit
python3 source/gps/gps_test.py DAC_Journal
echo "DONE";
echo "Finished at $(date)";
