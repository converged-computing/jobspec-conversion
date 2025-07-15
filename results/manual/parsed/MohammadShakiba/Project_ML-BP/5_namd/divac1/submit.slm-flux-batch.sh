#!/bin/bash
#FLUX: --job-name=namd-divac1
#FLUX: -c=10
#FLUX: --queue=valhalla  --qos=valhalla
#FLUX: -t=72000
#FLUX: --priority=16

export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export OMP_NUM_THREADS='$omp_threads'

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST="$SLURM_JOB_NODELIST
echo "SLURM_NNODES="$SLURM_NNODES
echo "SLURMTMPDIR="$SLURMTMPDIR
echo "working directory="$SLURM_SUBMIT_DIR
module load jupyterB
eval "$(/projects/academic/cyberwksp21/Software/Conda/Miniconda3/bin/conda shell.bash hook)"
conda activate libra
NPROCS=`srun --nodes=${SLURM_NNODES} bash -c 'hostname' |wc -l`
echo NPROCS=$NPROCS
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
if [ -n "$SLURM_CPUS_PER_TASK" ]; then
  omp_threads=$SLURM_CPUS_PER_TASK
else
  omp_threads=1
fi
export OMP_NUM_THREADS=$omp_threads
echo "OMP_NUM_THREADS="$OMP_NUM_THREADS
python run_namd.py > o
