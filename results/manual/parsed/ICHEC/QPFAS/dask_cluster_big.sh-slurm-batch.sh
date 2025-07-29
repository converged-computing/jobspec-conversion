#!/bin/bash
#SBATCH --account=ichec004
#SBATCH --mail-user=james.nelson@ichec.ie
#SBATCH --mail-type=END
#SBATCH --nodes=8
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=3-00:00:00

cd $SLURM_SUBMIT_DIR
module load intel/2020u4
module load conda
echo "Starting Dask Cluster"
echo "With" $1 "-1 workers"
echo "Scheduler is" $2".json"
mpirun --np $1 dask-mpi --scheduler-file $2".json" #--interface ib0
echo "Dask Cluster stopped"
