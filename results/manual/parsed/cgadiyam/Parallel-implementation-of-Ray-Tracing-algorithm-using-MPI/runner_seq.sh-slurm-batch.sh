#!/bin/bash
#SBATCH --job-name=rt_seq
#SBATCH --output=rt_seq.out
#SBATCH --error=rt_seq.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --partition=class

./raytrace_seq -h 5000 -w 5000 -c configs/box.xml -p none
