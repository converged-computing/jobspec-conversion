#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/CEGRcode/2023-Breugel_JournalXXXX/00_Download_and_Preprocessing/3_normalize_samples.sh
