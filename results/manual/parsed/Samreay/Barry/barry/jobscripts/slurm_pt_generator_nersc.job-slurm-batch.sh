#!/bin/bash
#SBATCH --job-name={name}
#SBATCH --account={account}
#SBATCH --output={output}.o%j
#SBATCH --nodes=1
#SBATCH --ntasks=20
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=4GB
#SBATCH --time=04:00:00
#SBATCH --qos=shared
#SBATCH --constraint=haswell

source ~/.bashrc.ext
source /global/common/software/desi/users/adematti/cosmodesi_environment.sh main
echo "Activated python"
echo `which python`
cd {path}
mpirun python precompute_mpi.py --model {model} --reconsmoothscale {reconsmoothscale} --redshift {z} --om {om} --h0 {h0} --ob {ob} --ns {ns} --mnu {mnu}
