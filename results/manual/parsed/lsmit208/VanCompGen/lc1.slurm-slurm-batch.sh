#!/bin/bash
#SBATCH --job-name=lc1_job
#SBATCH --output=lc1_job.out
#SBATCH --error=lc1_job.err
#SBATCH --mail-user=logan.b.smith@vanderbilt.edu
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=1G
#SBATCH --time=00:15:00

module load GCC Python
module load Pysam
python livecoding.py -b 2.bam
