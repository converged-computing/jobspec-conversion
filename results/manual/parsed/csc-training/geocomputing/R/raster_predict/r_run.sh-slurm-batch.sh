#!/bin/bash
#SBATCH --account=project_200xxxx
#SBATCH --output=output.txt
#SBATCH --error=errors.txt
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1000
#SBATCH --time=00:10:00
#SBATCH --partition=small

module load r-env-singularity
if test -f ~/.Renviron; then
    sed -i '/TMPDIR/d' ~/.Renviron
fi
srun singularity_wrapper exec RMPISNOW --no-save -f rtest.R
