#!/bin/bash
#SBATCH --job-name=CA_EX8_stream
#SBATCH --output=/home/hpc/rzku/hpcv651h/ex_08/ex08_stream.out
#SBATCH --error=/home/hpc/rzku/hpcv651h/ex_08/ex08_stream.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH: --exclusive
#SBATCH --constraint=ntasks-per-node=1

set -x
set -v
module load intel
echo "ArraySize,MegaUpdatesPerSecond,ActualRuntime,MinimalRuntime,EdgeSize" > result_cb_xy.csv
srun ../bin/jacobi 512 1000 >> result_cb_xy.csv
touch ready
