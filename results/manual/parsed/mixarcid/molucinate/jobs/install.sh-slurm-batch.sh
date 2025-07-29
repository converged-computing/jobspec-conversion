#!/bin/bash
#SBATCH --job-name=install
#SBATCH --output=R-%x.%j.out
#SBATCH --error=R-%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=dept_cpu

cd ..
ls
cd ~/Data
mkdit mol-results
tar -xvf Zinc.tar.bz2
echo "Success!"
