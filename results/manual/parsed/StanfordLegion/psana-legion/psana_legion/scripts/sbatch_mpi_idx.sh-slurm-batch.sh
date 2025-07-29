#!/bin/bash
#SBATCH --job-name=psana_legion
#SBATCH --account=lcls
#SBATCH --nodes=16
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --qos=debug
#SBATCH --exclusive
#SBATCH --constraint=knl,quad,cache

export SIT_PSDM_DATA='$HOST_DATA_DIR/d/psdm'

singularity
exec
docker:stanfordlegion/psana-mpi:latest
HOST_PSANA_DIR=$HOME/psana_legion/psana-legion
HOST_DATA_DIR=$SCRATCH/data/reg
export SIT_PSDM_DATA=$HOST_DATA_DIR/d/psdm
echo "HOST_DATA_DIR=$HOST_DATA_DIR"
for n in 1 2 4 8 16; do
  for c in 128 64; do # 32 16 8 4 2 1
    srun -n $(( n * c )) -N $n --cpus-per-task $(( 256 / c )) --cpu_bind cores --output idx_n"$n"_c"$c".log \
      shifter \
        python $HOST_PSANA_DIR/psana_legion/mpi_idx.py
  done
done
