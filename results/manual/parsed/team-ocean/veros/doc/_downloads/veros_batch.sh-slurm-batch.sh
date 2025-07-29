#!/bin/bash
#SBATCH --job-name=veros_mysetup
#SBATCH --account=myaccount
#SBATCH --mail-user=your@email.xyz
#SBATCH --mail-type=ALL
#SBATCH --nodes=2
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

export OMP_NUM_THREADS='1'

export OMP_NUM_THREADS=1
veros resubmit -i my_run -n 8 -l 7776000 \
    -c "srun --mpi=pmi2 -- veros run my_setup.py -b jax -n 4 4" \
    --callback "sbatch veros_batch.sh"
