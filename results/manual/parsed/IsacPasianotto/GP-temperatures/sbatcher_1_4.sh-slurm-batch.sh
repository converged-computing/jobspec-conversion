#!/bin/bash
#SBATCH --job-name=GP_MASTER
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=128
#SBATCH --mem=450G
#SBATCH --time=1-12:00:00
#SBATCH --partition=EPYC
#SBATCH: --no-requeue
#SBATCH --nodelist=epyc001

export DASK_WORKER_PROCESSES='128'

echo "---------------------------------------------"
echo "SLURM job ID:        $SLURM_JOB_ID"
echo "SLURM job node list: $SLURM_JOB_NODELIST"
echo "DATE:                $(date)"
echo "HOSTNAME:            $(hostname)"
echo "---------------------------------------------"
source /u/dssc/ipasia00/test_dask/dask_epyc/bin/activate
export DASK_WORKER_PROCESSES=128
python3 -u infer_1_4.py 
