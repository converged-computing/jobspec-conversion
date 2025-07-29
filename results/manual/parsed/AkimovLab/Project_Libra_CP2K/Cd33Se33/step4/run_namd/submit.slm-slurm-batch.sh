#!/bin/bash
#SBATCH --mail-user=bsmith24@buffalo.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128000
#SBATCH --time=1-00:00:00
#SBATCH --partition=valhalla
#SBATCH --qos=valhalla
#SBATCH --constraint=ntasks-per-node=21

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST="$SLURM_JOB_NODELIST
echo "SLURM_NNODES="$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory="$SLURM_SUBMIT_DIR
python namd.py 
