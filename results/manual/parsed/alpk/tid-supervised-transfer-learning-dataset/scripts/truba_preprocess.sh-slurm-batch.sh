#!/bin/bash
#SBATCH --job-name=run_preprocess
#SBATCH --account=akindiroglu
#SBATCH --output=/truba_scratch/akindiroglu/Slurm/output/out-%j.out
#SBATCH --error=/truba_scratch/akindiroglu/Slurm/error/err-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=1

module load centos7.3/lib/cuda/10.1
module load centos7.3/comp/gcc/6.4
/truba/home/akindiroglu/Workspace/Libs/pytorch_nightly/bin/python generate_csv_files.py
