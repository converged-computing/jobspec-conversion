#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/stajichlab/Candida_lusitaniae/New_ref_genome/pipeline/02_realign.sh
