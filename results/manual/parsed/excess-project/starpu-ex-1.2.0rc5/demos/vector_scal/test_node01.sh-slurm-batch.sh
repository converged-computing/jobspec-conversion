#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/excess-project/starpu-ex-1.2.0rc5/demos/vector_scal/test_node01.sh
