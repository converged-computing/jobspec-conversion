#!/bin/bash
#SBATCH --job-name=example3
#SBATCH --output=example3.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --qos=normal

module load vis/gnuplot
python example1.py
source numpy16/bin/activate
python example3.py
deactivate
gnuplot gnuplot/time_vs_array_size.gpi
