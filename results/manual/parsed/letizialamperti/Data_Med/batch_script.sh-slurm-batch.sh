#!/bin/bash
#SBATCH --job-name=letizias-job
#SBATCH --account=sd29
#SBATCH --output=letizias-logfile-%j.log
#SBATCH --error=letizias-errorfile-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1,gpu

args="${@}"
module load daint-gpu
module load cray-python
srun -ul $HOME/miniconda3/envs/zioboia/bin/python wtf_10.py "${args}" -u
