#!/bin/bash
#SBATCH --job-name=example1
#SBATCH --output=example1.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=normal

module load vis/gnuplot
python example1.py
gnuplot gnuplot/time_vs_array_size.gpi
