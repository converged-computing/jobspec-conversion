#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CUAnschutzBDC/snakemake_pipelines/sc_long_read/snakecharmer.sh
