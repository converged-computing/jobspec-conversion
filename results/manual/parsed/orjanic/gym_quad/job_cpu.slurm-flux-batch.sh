#!/bin/bash
#FLUX: --job-name=cpu-training-quad
#FLUX: --queue=CPUQ
#FLUX: -t=3600
#FLUX: --urgency=16

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "Running from directory: $SLURM_SUBMIT_DIR"
echo "Name of the job: $SLURM_JOB_NAME"
echo "Job ID: $SLURM_JOB_ID"
echo "Job was ran on nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
module purge
module load intel/2022a #Python/3.8.2-GCCcore-9.3.0 CUDA/11.0.2-GCC-9.3.0
module list
python run3d.py --exp_id 10 --controller_scenario 3d_new --controller 1024 --scenario 3d_new
uname -a
