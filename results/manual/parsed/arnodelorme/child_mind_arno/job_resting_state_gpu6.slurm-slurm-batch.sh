#!/bin/bash
#SBATCH --job-name=ChildMindDL
#SBATCH --account=TG-IBN140002
#SBATCH --output=Child_mind_p100.%j.%N.out
#SBATCH --mail-user=adelorme@ucsd.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=25G
#SBATCH --time=2-00:00:00
#SBATCH --partition=gpu-shared

source ~/.bashrc
cd /projects/ps-nemar/child_mind_2020
module load matlab
matlab -nodisplay -nosplash -nodesktop < /projects/ps-nemar/child_mind_2020/restingstate_dl_comet6.m
