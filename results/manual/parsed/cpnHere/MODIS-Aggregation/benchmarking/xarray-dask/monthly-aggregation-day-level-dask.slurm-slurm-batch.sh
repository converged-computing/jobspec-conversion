#!/bin/bash
#SBATCH --job-name=mod_agg
#SBATCH --account=pi_jianwu
#SBATCH --output=%x-%j_dask-monthly-aggregation-day-level.out
#SBATCH --error=%x-%j_dask-monthly-aggregation-day-level.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=MaxMemPerNode
#SBATCH --qos=long+
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=1

srun /umbc/xfs1/cybertrn/common/Softwares/anaconda3/bin/python monthly-aggregation-day-level-dask.py
