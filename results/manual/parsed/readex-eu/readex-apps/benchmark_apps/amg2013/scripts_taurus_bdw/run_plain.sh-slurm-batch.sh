#!/bin/bash
#SBATCH --job-name=amg2013_plain
#SBATCH --account=p_readex
#SBATCH --output=amg2013_plain.out
#SBATCH --error=amg2013_plain.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=14
#SBATCH --mem=2200M
#SBATCH --time=00:30:00
#SBATCH --partition=broadwell
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=2

cd ..
module purge
source ./readex_env/set_env_plain.source
srun --cpu_bind=verbose,sockets --nodes 4 --ntasks-per-node 2 --cpus-per-task 14 ./test/amg2013_plain -P 2 2 2 -r 40 40 40 
