#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/mhamilton723/pyTrading/cluster_scripts/run_stock_rnn_gpu.pbs
