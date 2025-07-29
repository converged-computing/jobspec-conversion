#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/RMGDFT/rmgdft/Examples/NEGF_Au-benzene-Au_NCPP/job.summit_gpu
