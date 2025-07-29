#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/clinical-brain-networks/OCD_Naze_et_al_2022_Brain/structural/qsiprep_parallel_combined.pbs
