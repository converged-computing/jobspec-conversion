#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CSBG-LSU/BionoiNet/legacy/bionoi_ml_homology_reduced/mlp_img.sh
