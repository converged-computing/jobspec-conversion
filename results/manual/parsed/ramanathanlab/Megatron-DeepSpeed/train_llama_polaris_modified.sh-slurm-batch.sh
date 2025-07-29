#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/ramanathanlab/Megatron-DeepSpeed/train_llama_polaris_modified.sh
