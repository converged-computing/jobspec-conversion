#!/bin/bash
#SBATCH --output=log-%j.out
#SBATCH --error=log-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=256000
#SBATCH --time=2-00:00:00
#SBATCH --exclusive

