#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/PDAF/PDAF/modelbindings/AWI-CM1.4/tools/dis_cov/job_dist_covar.pbs
