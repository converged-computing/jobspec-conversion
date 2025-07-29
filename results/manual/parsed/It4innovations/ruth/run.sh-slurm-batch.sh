#!/bin/bash
#SBATCH --job-name=Ruth_Bench
#SBATCH --account=DD-23-154
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00
#SBATCH --partition=qcpu

ml purge
ml Python/3.10.8-GCCcore-12.2.0
ml GCC/12.2.0
ml SQLite/3.39.4-GCCcore-12.2.0
ml HDF5/1.14.0-gompi-2022b
ml CMake/3.24.3-GCCcore-12.2.0
ml Boost/1.81.0-GCC-12.2.0
source venv/bin/activate
python3 ruth/zeromq/bench.py workers_1_nodes_250k_full
