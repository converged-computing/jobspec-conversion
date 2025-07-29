#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WeipengMO/mowp_scripts/snakemake_pipelines/nanopolish_polya/scripts/run_guppy.sh
