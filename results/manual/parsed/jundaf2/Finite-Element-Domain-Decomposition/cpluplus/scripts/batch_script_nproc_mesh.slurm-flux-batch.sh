#!/bin/bash
#FLUX: --job-name=proj-benchmark
#FLUX: -N=3
#FLUX: --exclusive
#FLUX: -t=14400
#FLUX: --priority=16

export TOTAL_CPUS='$(( SLURM_JOB_NUM_NODES * PBS_NUM_PPN ))'

export TOTAL_CPUS=$(( SLURM_JOB_NUM_NODES * PBS_NUM_PPN ))
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SLURM_SUBMIT_DIR=${SLURM_SUBMIT_DIR:-${SCRIPT_DIR}/..}
PBS_O_WORKDIR=${PBS_O_WORKDIR:-${SCRIPT_DIR}/..}
cd ${SLURM_SUBMIT_DIR} #assumed to be the source tree
if [ -d "./cmake" ] && [ -d "./writeup" ]
then
    echo "We seem to be in the right place."
else
	echo "Not submit from the right place! Submit from the root of your repository."
	exit 1
fi
mkdir -p ${SLURM_SUBMIT_DIR}/build
pushd ${SLURM_SUBMIT_DIR}/build
:<<EOF
echo "Compiling"
cmake ${SLURM_SUBMIT_DIR} && make
EOF
echo "Testing Serial" >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_serial.txt
for FEDDM_RUNSPEC in 1.5 1.4 1.3 1.2 1.1 1 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.19 0.18 0.17 0.16 0.15 0.14 0.13 0.12 0.11 0.1
do
	echo "Doing Hmax = ${FEDDM_RUNSPEC} "
	echo "Doing Hmax = ${FEDDM_RUNSPEC} " >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_serial.txt
	./bin/feddm_serial_cg ${FEDDM_RUNSPEC} | grep "ASM serial version costs time" >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_serial.txt
done
echo "BEGIN _VARIES_" >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_mpi_openmp.txt
for FEDDM_RUNSPEC in 1.5 1.4 1.3 1.2 1.1 1 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.19 0.18 0.17 0.16 0.15 0.14 0.13 0.12 0.11 0.1
do
echo "Doing Hmax = ${FEDDM_RUNSPEC} "
echo "Doing Hmax = ${FEDDM_RUNSPEC} " >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_mpi_openmp.txt
for N_CPUS in 4 9 16 25 36
do
	#Individual MPI run
	echo "Doing MPI CPUS = ${N_CPUS} "
	echo "Doing MPI CPUS = ${N_CPUS} " >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_mpi_openmp.txt
	srun --mpi=pmi2 --ntasks-per-node ${SLURM_NTASKS_PER_NODE} --cpu-bind=cores --ntasks ${N_CPUS} /projects/cs/cs484/sing_exec.sh ./bin/feddm_parallel_cg ${FEDDM_RUNSPEC} | grep "MPI ASM FEM costs time" >> ${SLURM_SUBMIT_DIR}/writeup/benchmark_mpi_openmp.txt
done
done
