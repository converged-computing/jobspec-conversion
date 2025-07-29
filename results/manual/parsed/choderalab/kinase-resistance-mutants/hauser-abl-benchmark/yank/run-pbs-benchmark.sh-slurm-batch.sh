#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/choderalab/kinase-resistance-mutants/hauser-abl-benchmark/yank/run-pbs-benchmark.sh
