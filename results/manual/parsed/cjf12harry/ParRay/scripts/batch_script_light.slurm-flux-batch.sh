#!/bin/bash
#FLUX: --job-name=parRay-team7
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: -t=4800
#FLUX: --priority=16

echo `whoami`
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo $SCRIPT_DIR
SLURM_SUBMIT_DIR=${SLURM_SUBMIT_DIR:-${SCRIPT_DIR}/..}
echo $SLURM_SUBMIT_DIR
cd ${SLURM_SUBMIT_DIR} #assumed to be the source tree
if [ -d "./src" ]
then
	echo "We seem to be in the right place."
else
	echo "Not submit from the right place! Submit from the root of your repository."
	exit 1
fi
if [ -d "./build" ]
then
	rm -rf ./build
fi
SING_EXEC_LOCATION=${SLURM_SUBMIT_DIR}/scripts/sing_exec.sh
SING_SH_LOCATION=${SLURM_SUBMIT_DIR}/scripts/sing_shell.sh
BIN_DIR=${SLURM_SUBMIT_DIR}/build/bin
mkdir -p ${SLURM_SUBMIT_DIR}/build
pushd ${SLURM_SUBMIT_DIR}/build
echo "Compiling"
srun --mpi=pmi2 --ntasks 1 --nodes=1 ${SING_EXEC_LOCATION} cmake ${SLURM_SUBMIT_DIR}/src && \
srun --mpi=pmi2 --ntasks 1 --nodes=1 ${SING_EXEC_LOCATION} make
echo "Run Tests"
srun --mpi=pmi2 --ntasks 1 --nodes=1 ${SING_EXEC_LOCATION}  "${BIN_DIR}/bvh_test"
srun --mpi=pmi2 --ntasks 1  --nodes=1 ${SING_EXEC_LOCATION}  "${BIN_DIR}/data_porting_test"
echo "Run Benchmarks"
srun --mpi=pmi2 --ntasks 1 --nodes=1 ${SING_EXEC_LOCATION}  "${BIN_DIR}/gen_random_scene 5"
for N_CPUS in 2
do
	#Individual MPI run
	echo "Doing MPI CPUS = ${N_CPUS} "
	srun --mpi=pmi2 --cpu-bind=cores --ntasks ${N_CPUS} ${SING_EXEC_LOCATION} "${BIN_DIR}/bm_mpi ./random_spheres_scene.data 2"
done
