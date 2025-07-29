#!/bin/bash
#SBATCH --job-name=archive_deployment
#SBATCH --account=mwaops
#SBATCH --error=err-%j.log
#SBATCH --nodes=10
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=1

module swap PrgEnv-cray PrgEnv-gnu
module load python/2.7.10
module load mpi4py
APP_ROOT="/scratch2/mwaops/cwu/dfms"
SID=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_DIR=$APP_ROOT"/logs/"$SID
mkdir -m $LOG_DIR # to remove potential directory creation conflicts later
aprun -B /home/cwu/dfms_env/bin/python $APP_ROOT"/cluster/start_dfms_cluster.py" -l $LOG_DIR -g 7 -d
