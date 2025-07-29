#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/McIntyre-Lab/papers/fear_ase_2016/scripts/ase_pipeline/run_sam_compare_python.qsub
