#!/bin/bash
#SBATCH --job-name=BundleRigFl
#SBATCH --output=slurm_%j.out
#SBATCH --mail-user=om759@nyu.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=8GB
#SBATCH --time=2-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-5

module purge
module load python/intel/3.8.6
module load cuda/11.6.2
module load onetbb/intel/2021.1.1
cd SlenderBody/Examples
python FixedDynamicLinkNetwork.py $SLURM_ARRAY_TASK_ID 0.00005 2
