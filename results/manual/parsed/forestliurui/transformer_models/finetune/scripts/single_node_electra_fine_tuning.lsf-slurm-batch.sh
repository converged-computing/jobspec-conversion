#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/forestliurui/transformer_models/finetune/scripts/single_node_electra_fine_tuning.lsf
