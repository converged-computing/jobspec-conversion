#!/bin/bash
#SBATCH --job-name=StdModel_target_noCross
#SBATCH --output=/scratch/%u/StdVisualModel/logs/%x_out-%a.txt
#SBATCH --error=/scratch/%u/StdVisualModel/logs/%x_error-%a.txt
#SBATCH --mail-user=%u@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=48GB
#SBATCH --time=2-00:00:00
#SBATCH --array=1-48

module load matlab/2021a
matlab <<EOF
s0_add_paths
doCross=false;
target='target';
start_idx=1;
% if choose_model = 'all', the total number of array jobs is 48 - if only one model is selected 12 array jobs
choose_model='all'; 
s2_fit_all_cluster
EOF
