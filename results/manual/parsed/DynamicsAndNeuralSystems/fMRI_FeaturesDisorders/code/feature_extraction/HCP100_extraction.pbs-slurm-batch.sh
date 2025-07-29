#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/DynamicsAndNeuralSystems/fMRI_FeaturesDisorders/code/feature_extraction/HCP100_extraction.pbs
