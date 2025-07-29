#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/StanfordLegion/psana-legion/lcls2/proxy_app/bsub_gpu.sh
