#!/bin/bash
#SBATCH --job-name=0709_0_12
#SBATCH --account=amt
#SBATCH --output=0709_0_12.out
#SBATCH --error=0709_0_12.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=100000M
#SBATCH --time=20-00:00:00
#SBATCH --partition=amt
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=n237

module load tensorflow
python3 time_miner.py 2018-07-09T00:01:10.0Z 2018-07-09T12:00:00.0Z
