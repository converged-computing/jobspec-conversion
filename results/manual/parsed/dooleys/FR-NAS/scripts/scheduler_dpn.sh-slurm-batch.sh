#!/bin/bash
#SBATCH --job-name=fairnas
#SBATCH --output=logs/%j.%x.%N.out
#SBATCH --error=logs/%j.%x.%N.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=6-00:00:00

dask-scheduler --scheduler-file  "scheduler-dpn-file.json" --idle-timeout 1000000000000000000000000 --port 1796
