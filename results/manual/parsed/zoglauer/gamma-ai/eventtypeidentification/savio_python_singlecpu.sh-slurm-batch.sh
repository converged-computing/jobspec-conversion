#!/bin/bash
#SBATCH --job-name=Python
#SBATCH --account=fc_cosi
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=02:00:00
#SBATCH --partition=savio2
#SBATCH --qos=savio_normal

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'

echo "Starting submit on host ${HOSTNAME}..."
echo "Loading modules..."
module load gcc/4.8.5 cmake python/3.6 cuda tensorflow
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
python3 -u run.py -f 1MeV_50MeV_flat.p1.inc18166611.id1.sim.gz
wait
