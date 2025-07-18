#!/bin/bash
#FLUX: --job-name=STARsolo
#FLUX: -t=172740
#FLUX: --urgency=16

export PYTHONUNBUFFERED='TRUE'

module purge
module load snakemake/6.12.3
module load samtools/intel/1.14
module load python/intel/3.8.6
module load macs3/intel/3.0.0a5
module load bedtools/intel/2.29.2
module load r/gcc/4.3.1
export PYTHONUNBUFFERED=TRUE
echo "SLURM Environment: ${SLURM_JOB_NUM_NODES} Nodes ${SLURM_NTASKS} Tasks ${SLURM_MEM_PER_NODE} Memory/Node"
echo ""
time "$@"
