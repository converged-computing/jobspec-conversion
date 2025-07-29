#!/bin/bash
#SBATCH --job-name=prepInputs
#SBATCH --output=/scratch/%u/StdVisualModel/logs/%x_out-%a.txt
#SBATCH --error=/scratch/%u/StdVisualModel/logs/%x_error-%a.txt
#SBATCH --mail-user=%u@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=64GB
#SBATCH --time=1-00:00:00

module load matlab/2021a
matlab <<EOF
s0_add_paths
s1_prepare_inputs(1)
s1_prepare_inputs(2)
s1_prepare_inputs(3)
s1_prepare_inputs(4)
EOF
