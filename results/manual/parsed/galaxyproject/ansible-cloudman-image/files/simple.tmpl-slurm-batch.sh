#!/bin/bash
#SBATCH --job-name=<%=
#SBATCH --output=<%=
#SBATCH --error=<%=
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-<%=

R CMD BATCH --no-save --no-restore "<%= rscript %>" /dev/stdout
