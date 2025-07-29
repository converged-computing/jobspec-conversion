#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Mele-Lab/2023_BloodTraitsMPRA_CellGenomics/Hypertension_paper/data/design/get_genes_overlapped.sh
