#!/bin/bash
#SBATCH --job-name=feature_extraction
#SBATCH --account=imi@cpu
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1gb
#SBATCH --time=02:00:00
#SBATCH --partition=cpu_p1

export MASTER_PORT='1234'
export MASTER_ADDRESS='$(echo $slurm_nodes | cut -d' ' -f1)'
export n='6'

export MASTER_PORT=1234
slurm_nodes=$(scontrol show hostnames $SLURM_JOB_NODELIST)
echo $slurm_nodes
export MASTER_ADDRESS=$(echo $slurm_nodes | cut -d' ' -f1)
echo $MASTER_ADDRESS
module purge
module load pytorch-cpu/py3/1.7.1
module load openmpi/4.0.5
set -x
export n=6
srun -n $n -pty bash -c './feature_extraction/neos_feature_extraction.sh data/dekaworld_alex_guille_neosdata2 --replace_existing'
