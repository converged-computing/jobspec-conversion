#!/bin/bash
#FLUX: --job-name=iPI Benchmark
#FLUX: -n=16
#FLUX: -t=3600
#FLUX: --urgency=16

date
module purge
module load gcc/9.3.0
module load cmake/3.25.0
module load openmpi/4.1.4
module load openblas/0.3.20
module load petsc/3.15.5
module load python/3.11.2
module load boost/1.74.0
module list
lscpu
cd ../../release
make
e=ATC
if [ "$e" == "MDP" ]; then
    python ../benchmarks/SolverTolerance/run_benchmark_MDP.py
    python ../benchmarks/SolverTolerance/plot.py --path ../output/MDP/SolverTolerance/$SLURM_JOB_ID
elif [ "$e" == "GM" ]; then
    python ../benchmarks/SolverTolerance/run_benchmark_GM.py
    python ../benchmarks/SolverTolerance/plot.py --path ../output/GM/SolverTolerance/$SLURM_JOB_ID
elif [ "$e" == "IDM" ]; then
    python ../benchmarks/SolverTolerance/run_benchmark_IDM.py
    python ../benchmarks/SolverTolerance/plot.py --path ../output/IDM/SolverTolerance/$SLURM_JOB_ID
elif [ "$e" == "ATC" ]; then
    python ../benchmarks/SolverTolerance/run_benchmark_ATC.py
    python ../benchmarks/SolverTolerance/plot.py --path ../output/ATC/SolverTolerance/$SLURM_JOB_ID
else
    echo "Invalid value of e. It should be either 'MDP', 'GM' or 'IDM'."
    exit 1
fi
