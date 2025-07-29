#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/vari-bbc/MethodsInGenomics-Oct2021/snakemake_demo/bin/run_snakemake.sh
