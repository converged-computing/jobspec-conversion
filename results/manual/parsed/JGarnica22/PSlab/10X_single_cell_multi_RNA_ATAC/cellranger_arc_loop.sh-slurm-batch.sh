#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/JGarnica22/PSlab/10X_single_cell_multi_RNA_ATAC/cellranger_arc_loop.sh
