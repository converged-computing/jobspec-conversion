#!/bin/bash
#SBATCH --output=/home/zhouqua1/NCPOP/out.out
#SBATCH --error=/home/zhouqua1/NCPOP/err.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --partition=amd

ml mosek/9.2
ml Python/3.9.6-GCCcore-11.2.0
python /home/zhouqua1/NCPOP/ncpop_stock.py
