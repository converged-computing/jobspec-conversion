#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/brendanjohnharris/Criticality/Feature_Analysis/Classification/ML/Analysis2/rbfSVM/PBS_Analysis2_rbfSVM.sh
