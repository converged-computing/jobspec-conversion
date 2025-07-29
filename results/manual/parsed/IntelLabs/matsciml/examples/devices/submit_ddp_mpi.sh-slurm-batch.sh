#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=8

export ZE_FLAT_DEVICE_HIERARCHY='FLAT'

module purge
module load default-dawn
module load intel-oneapi-compilers
module load intelpython-conda
module load intel-oneapi-mkl
module load intel-oneapi-mpi
module load intel-oneapi-ccl
conda activate matsciml
export ZE_FLAT_DEVICE_HIERARCHY=FLAT
ulimit -n 60000
scontrol show hostnames >hostfile
mpirun -n $SLURM_NTASKS \
	-ppn $SLURM_NTASKS_PER_NODE \
	-f hostfile \
	-bootstrap ssh \
	-bootstrap-exec-args "-t" \
	-map-by socket \
	python xpu_ddp_mpi.py
