#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/jason-fer/Theano-DBNs-For-Drug-Discovery/sbel_jobs/sk_random_forests/pbs-random_forests-pcba.sh
