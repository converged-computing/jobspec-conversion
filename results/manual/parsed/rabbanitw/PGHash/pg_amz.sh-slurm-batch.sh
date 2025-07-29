#!/bin/bash
#SBATCH --job-name=pg-amz
#SBATCH --account=scavenger
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128gb
#SBATCH --time=2-22:00:00
#SBATCH --partition=scavenger
#SBATCH --qos=normal

module purge
module load mpi
module load cuda/11.4.4
source ../../../../cmlscratch/marcob/environments/pghash/bin/activate
mpirun -n 1 python run_pg.py --hash_type pghash --dwta 1 --steps_per_test 100 --train_bs 256 --dataset Amazon670K --cr 1 --epochs 10 --name run2 --randomSeed 239 --k 8 --c 8 --num_tables 50 --steps_per_lsh 50
