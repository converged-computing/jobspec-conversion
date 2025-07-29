#!/bin/bash
#SBATCH --job-name=Ray-CPU
#SBATCH --account=m2043
#SBATCH --nodes=5
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=haswell

export HDF5_USE_FILE_LOCKING='FALSE'

trainTime=200
useDataFrac=0.05
steps=10
numHparams=10
numCPU=20 # number of CPUs used by each ray tune trial
module load tensorflow/gpu-2.1.0-py37
export HDF5_USE_FILE_LOCKING=FALSE
let "worker_num=(${SLURM_NTASKS} - 1)"
suffix='6379'
ip_head=`hostname`:$suffix
export ip_head # Exporting for latter access by trainer.py
srun --nodes=1 --ntasks=1 --nodelist=`hostname` ray start --head --block --port=6379  &
sleep 30
srun --nodes=${worker_num} --ntasks=${worker_num} --exclude=`hostname` ray start --address $ip_head --block &
sleep 5
python ./train_RayTune.py --dataPath /global/homes/b/balewski/prjn/neuronBBP-pack40kHzDisc/probe_quad/bbp153 --probeType quad -t $trainTime --useDataFrac $useDataFrac --steps $steps --rayResult $SCRATCH/ray_results --numHparams $numHparams --nodes CPU --numCPU $numCPU
