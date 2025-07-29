#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

/workspaces/fractale/jobspec-conversion/data/WashU-IT-RIS/docker-osu-micro-benchmarks/bin/osu-gpu.bsub
