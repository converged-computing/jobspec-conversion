#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/VBF-HZZ/SubmitArea_13TeV/submitFileLHEGENSIM.pbs.sh
