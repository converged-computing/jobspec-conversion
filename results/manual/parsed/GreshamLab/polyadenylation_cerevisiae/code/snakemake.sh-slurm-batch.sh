#!/bin/bash
#SBATCH --job-name=STARsolo
#SBATCH --output=snake_out/%j.out
#SBATCH --error=snake_out/%j.err
#SBATCH --mail-user=sz4633@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=160000
#SBATCH --time=1-23:59:00
#SBATCH --constraint=ntasks-per-node=16

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
