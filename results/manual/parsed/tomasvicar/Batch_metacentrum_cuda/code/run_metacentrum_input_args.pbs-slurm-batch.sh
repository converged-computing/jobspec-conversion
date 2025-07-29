#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/tomasvicar/Batch_metacentrum_cuda/code/run_metacentrum_input_args.pbs
