#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/francescomambretti/Li2NH-LiNH2_mix/scripts/QE/QE_run/scf_job_franklin_CPU.sh
