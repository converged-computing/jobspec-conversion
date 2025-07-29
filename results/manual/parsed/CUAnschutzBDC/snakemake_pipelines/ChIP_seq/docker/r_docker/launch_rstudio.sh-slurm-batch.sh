#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CUAnschutzBDC/snakemake_pipelines/ChIP_seq/docker/r_docker/launch_rstudio.sh
