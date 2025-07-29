#!/bin/bash
#SBATCH --job-name=thermalmetrics
#SBATCH --account=iidd
#SBATCH --output=glm3pb0_sing.out
#SBATCH --mail-user=lplatt@usgs.gov
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=72
#SBATCH --mem=192GB
#SBATCH --time=2-00:00:00
#SBATCH --partition=cpu

module load singularity/3.3.0
ulimit -u 1541404
srun singularity exec \
    lake-temperature-out.sif \
    Rscript glm3pb0_run.R
