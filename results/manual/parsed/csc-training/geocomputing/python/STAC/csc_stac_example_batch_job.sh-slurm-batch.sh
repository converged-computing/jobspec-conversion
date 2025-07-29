#!/bin/bash
#SBATCH --account=project_2000599
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=10G
#SBATCH --time=00:20:00

module load geoconda
python csc_stac_example.py
