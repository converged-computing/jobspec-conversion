#!/bin/bash
#SBATCH --job-name=pg-wiki
#SBATCH --account=scavenger
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128gb
#SBATCH --time=2-22:00:00
#SBATCH --qos=normal

module purge
module load mpi
module load cuda/11.4.4
source ../../../../cmlscratch/marcob/environments/pghash/bin/activate
mpirun -n 1 python run_pg.py --hash_type pghash --steps_per_test 100 --train_bs 256 --dataset Wiki325K --cr 1 --name run1 --randomSeed 1203 --test_bs 8192 --num_tables 50 --steps_per_lsh 50 --k 5 --dwta 1 --c 16
