#!/bin/bash
#SBATCH --job-name=newexp
#SBATCH --account=desi
#SBATCH --output=newexp_%j.log
#SBATCH --nodes=45
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug

export TMPDIR='/dev/shm'
export OMP_NUM_THREADS='1'
export DESI_SPECTRO_SIM='${simdir}'
export PIXPROD='${prod}'

echo Starting slurm script at `date`
nodes=45
node_proc=1
export TMPDIR=/dev/shm
cpu_per_core=2
node_cores=24
node_thread=$(( node_cores / node_proc ))
node_depth=$(( cpu_per_core * node_thread ))
procs=$(( nodes * node_proc ))
export OMP_NUM_THREADS=1
simdir="${SCRATCH}/desi/sim"
prod="quercus"
export DESI_SPECTRO_SIM="${simdir}"
export PIXPROD="${prod}"
run="srun --cpu_bind=no -n ${procs} -N ${nodes}"
com="${run} python mpi_newexp_random.py"
echo ${com}
time ${com} 2>&1
