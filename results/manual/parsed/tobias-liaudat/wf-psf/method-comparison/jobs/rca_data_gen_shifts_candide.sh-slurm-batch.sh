#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tobias-liaudat/wf-psf/method-comparison/jobs/rca_data_gen_shifts_candide.sh
