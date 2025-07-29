#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/biosustain/dsp_nf-metagenomics/old_scripts/kneaddata_raw_filtered.sh
