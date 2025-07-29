#!/bin/bash
#SBATCH --job-name=LST
#SBATCH --account=dyarkon1
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

set -e
date
module list
python lst.py
date
sacct --name=LST --format="JobID,JobName,Elapsed,State"
