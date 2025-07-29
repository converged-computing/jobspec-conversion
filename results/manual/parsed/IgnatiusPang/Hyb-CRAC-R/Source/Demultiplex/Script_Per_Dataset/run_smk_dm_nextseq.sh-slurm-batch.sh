#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/IgnatiusPang/Hyb-CRAC-R/Source/Demultiplex/Script_Per_Dataset/run_smk_dm_nextseq.sh
