#!/bin/bash
#SBATCH --job-name=sim_TAB_gen_ni
#SBATCH --output=sim_TAB_gen_ni_%A.out
#SBATCH --error=sim_TAB_gen_ni_%A.err
#SBATCH --mail-user=chufengl@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32000
#SBATCH --time=1-00:12:00

module load matlab/2016a
matlab -nodesktop  -r "addpath('/home/chufengl/test_folder/MOF_pat_sim','-end'); TAB_gen_ni;exit"
