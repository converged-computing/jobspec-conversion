#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CSBG-LSU/BionoiNet/bionoi_cnn_homology_reduced/resnet18.sh
