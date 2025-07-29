#!/bin/bash
#SBATCH --job-name=self_5_to_17_imps
#SBATCH --account=rac-2018-hpcg1742
#SBATCH --mail-user=pavithran.sridhar@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4096
#SBATCH --time=1-00:00:00

./benchmarking input.txt
