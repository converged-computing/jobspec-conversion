#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/Liebeck/ArgMining/scripts/sentence/hilbert/hilbert_data_v3_jobarray.job
