#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/UIUC-CS547-2021sp-Group36/project/final_runs/train_run.rescale_resnet101.bash
