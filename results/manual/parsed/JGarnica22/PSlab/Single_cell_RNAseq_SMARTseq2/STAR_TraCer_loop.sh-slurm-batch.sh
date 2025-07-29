#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JGarnica22/PSlab/Single_cell_RNAseq_SMARTseq2/STAR_TraCer_loop.sh
