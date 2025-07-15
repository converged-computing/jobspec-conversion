#!/bin/bash
#FLUX: --job-name=fullNodeMeasures
#FLUX: -c=64
#FLUX: -t=600
#FLUX: --priority=16

export OMP_PROC_BIND='SPREAD'
export OMP_NUM_THREADS='1'

module load PrgEnv-cray
export OMP_PROC_BIND=SPREAD
echo -e "\n\n========================================"
echo        "========================================"
export OMP_NUM_THREADS=1
echo "Measuring Peak Performance THREADS=$OMP_NUM_THREADS"
echo "Using: srun -l -u -n 1 -c $OMP_NUM_THREADS dgemm 1600 | sort -n"
srun -l -u -n 1 -c $OMP_NUM_THREADS dgemm 1600 | sort -n
echo -e "\n\n========================================"
echo        "========================================"
export OMP_NUM_THREADS=1
echo "Measuring Peak Performance full chip THREADS=$OMP_NUM_THREADS"
echo "Using: srun -l -u -n 64 -c $OMP_NUM_THREADS dgemm 1600 |sort -n"
srun -l -u -n 64 -c $OMP_NUM_THREADS dgemm 1600 | sort -n
export OMP_NUM_THREADS=1
echo -e "\n\n========================================"
echo        "========================================"
echo "Measuring Peak Mem Bandwidth THREADS=$OMP_NUM_THREADS"
echo "With srun using: srun -c $SLURM_CPUS_PER_TASK ./stream"
srun -c $SLURM_CPUS_PER_TASK ./stream
echo -e "\n\n========================================"
echo        "========================================"
echo "Measuring Peak Mem Bandwidth THREADS=$OMP_NUM_THREADS"
echo "With srun using: srun -c $OMP_NUM_THREADS ./stream"
srun -c $OMP_NUM_THREADS ./stream
echo -e "\n\n========================================"
echo        "========================================"
echo "Measuring Peak Mem Bandwidth THREADS=$OMP_NUM_THREADS"
echo "WithOUT srun using: ./stream"
./stream
echo -e "\n\n========================================"
echo        "========================================"
echo "Done"
