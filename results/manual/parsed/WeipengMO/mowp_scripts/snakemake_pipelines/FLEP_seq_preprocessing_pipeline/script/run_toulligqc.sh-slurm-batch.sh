#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WeipengMO/mowp_scripts/snakemake_pipelines/FLEP_seq_preprocessing_pipeline/script/run_toulligqc.sh
