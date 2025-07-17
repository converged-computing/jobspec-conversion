#!/bin/bash
#FLUX: --job-name=pg-amz
#FLUX: --queue=scavenger
#FLUX: -t=252000
#FLUX: --urgency=16

module purge
module load mpi
module load cuda/11.4.4
source ../../../../cmlscratch/marcob/environments/pghash/bin/activate
mpirun -n 1 python run_pg.py --hash_type pghash --dwta 1 --steps_per_test 100 --train_bs 256 --dataset Amazon670K --cr 1 --epochs 10 --name run2 --randomSeed 239 --k 8 --c 8 --num_tables 50 --steps_per_lsh 50
