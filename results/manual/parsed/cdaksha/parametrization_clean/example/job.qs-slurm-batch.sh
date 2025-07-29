#!/bin/bash
#SBATCH --job-name=OPT-1
#SBATCH --output=/lustre/scratch/daksha/202002-ZnO-results/base_case/1/run.out
#SBATCH --error=/lustre/scratch/daksha/202002-ZnO-results/base_case/1/run_error.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00

. /opt/shared/slurm/templates/libexec/common.sh
vpkg_require reaxff/2.0.1:intel
vpkg_require intel-python/2019u2:python3
vpkg_require pandas-tf2
time bash main.sh
