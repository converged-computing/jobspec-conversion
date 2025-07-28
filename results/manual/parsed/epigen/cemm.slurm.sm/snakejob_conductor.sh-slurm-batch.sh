#!/bin/bash
#FLUX: --job-name=analysis_project_name
#FLUX: --queue=longq
#FLUX: -t=57600
#FLUX: --urgency=16

echo "======================"
echo $SLURM_SUBMIT_DIR
echo $SLURM_JOB_NAME
echo $SLURM_JOB_PARTITION
echo $SLURM_NTASKS
echo $SLURM_NPROCS
echo $SLURM_JOB_ID
echo $SLURM_JOB_NUM_NODES
echo $SLURM_NODELIST
echo $SLURM_CPUS_ON_NODE
echo "======================"
source <path/to/conda>/miniconda3/etc/profile.d/conda.sh
conda activate <snakemake_environment_name>
cd <path/to/workflow>
date
snakemake -p --use-conda
date
