#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/GeoscienceAustralia/landshark/check_tfp_nn_keras_reg_hw1/pred_parts.sh
