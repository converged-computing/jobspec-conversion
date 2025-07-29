#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Animadversio/Visual_Neuro_InSilico_Exp/cluster_scripts/insilico_manifold_resize_DenseNet.sh
