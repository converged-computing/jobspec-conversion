#!/bin/bash
#SBATCH --account=y95
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:00:00

module load nextflow
module load java
srun --export=all nextflow run -profile singularity,zeus -resume ./main.nf --nanoporeReads '$*'
