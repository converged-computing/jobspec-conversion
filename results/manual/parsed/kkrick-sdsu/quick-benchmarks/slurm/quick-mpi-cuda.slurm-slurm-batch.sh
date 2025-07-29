#!/bin/bash
#SBATCH --job-name=quick-mpi-cuda
#SBATCH --account=sdu135
#SBATCH --output=quick-out-mpi-cuda.%j.%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=4
#SBATCH --mem=93G
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=4
#SBATCH --no-requeue

module reset
module load singularitypro
singularity exec --nv --bind /expanse,/scratch \
    containers/quick_mpi-cuda-12.0.1.sif \
    ./bench.sh \
    -i ./input \
    -o ./output \
    -f psb5,morphine,taxol,valinomycin \
    -c quick.cuda.MPI
