#!/bin/bash
#SBATCH --output=slurm.%j.out
#SBATCH --error=slurm.%j.err
#SBATCH --mail-user=chufengl@asu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1-00:12:00
#SBATCH --partition=serial

module load matlab/2015a
matlab -nodesktop  -r "mat2h5('/home/chufengl/test_folder/MOF_pat_sim/MOF_batch13','MOF_2C_Zn_edge',1,40)"
