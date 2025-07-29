#!/bin/bash
#FLUX: --job-name=DECONTAMINATION
#FLUX: --queue=standard
#FLUX: -t=259200
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo "" 
source /home/${USER}/.bashrc
SCRATCH="/scratch/qi47rin"
mamba activate snakemake
snakemake  \
    --snakefile manager.smk \
    --profile /home/qi47rin/proj/02-compost-microbes/src/ \
    --singularity-prefix cache/00-singularity \
    --conda-prefix cache/00-conda-env \
    --singularity-args "--bind $SCRATCH" \
    --conda-frontend mamba \
    --nolock
