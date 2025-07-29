#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/huishenlab/multiscale_methylation_plot_pipeline/bin/run_snakemake_workflow.sh
