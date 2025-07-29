#!/bin/bash
#SBATCH --job-name=dask_cluster
#SBATCH --nodes=7
#SBATCH --ntasks=7
#SBATCH --cpus-per-task=36
#SBATCH --time=05:00:00

export OMP_NUM_THREADS='$CPUS_ON_NODE'
export MPLBACKEND='agg'
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'

export OMP_NUM_THREADS=$CPUS_ON_NODE
export MPLBACKEND="agg"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
echo $SLURM_PROCID
srun -N 1 -n1 dask-scheduler --scheduler-file $HOME/scheduler.json &
sleep 4
for((i=2; i<=$SLURM_NNODES; i++))
do 
   echo "Starting worker..." $i
   srun -N1 -n1 dask-worker --scheduler-file $HOME/scheduler.json --nthreads 1 --nprocs 36 &
done
python crsim_multidop_testing.py /home/rjackson/scheduler.json
