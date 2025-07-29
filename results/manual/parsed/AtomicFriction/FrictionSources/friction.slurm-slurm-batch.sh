#!/bin/bash
#SBATCH --job-name=is-ismi
#SBATCH --account=proj9
#SBATCH --nodes=1
#SBATCH --ntasks=28
#SBATCH --cpus-per-task=1
#SBATCH --time=10:00:00

module load centos7.3/comp/python/3.8.12-openmpi-4.1.1-oneapi-2021.2
python3.8 main.py
exit
