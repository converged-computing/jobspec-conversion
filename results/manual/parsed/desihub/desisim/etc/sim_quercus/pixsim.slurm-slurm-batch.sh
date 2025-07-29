#!/bin/bash
#SBATCH --job-name=pixsim
#SBATCH --account=desi
#SBATCH --output=pixsim_%j.log
#SBATCH --nodes=150
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug

export TMPDIR='/dev/shm'
export OMP_NUM_THREADS='${node_thread}'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export DESI_SPECTRO_SIM='${simdir}'
export PIXPROD='${prod}'
export DESI_SPECTRO_DATA='${simdir}/${prod}'

echo Starting slurm script at `date`
nodes=150
node_proc=6
export TMPDIR=/dev/shm
cpu_per_core=2
node_cores=24
node_thread=$(( node_cores / node_proc ))
node_depth=$(( cpu_per_core * node_thread ))
procs=$(( nodes * node_proc ))
export OMP_NUM_THREADS=${node_thread}
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
simdir="${SCRATCH}/desi/sim"
prod="quercus"
export DESI_SPECTRO_SIM="${simdir}"
export PIXPROD="${prod}"
export DESI_SPECTRO_DATA="${simdir}/${prod}"
run="srun --cpu_bind=cores -n ${procs} -N ${nodes} -c ${node_depth}"
com="${run} pixsim_nights --verbose --cosmics --preproc --camera_procs ${node_proc}"
echo ${com}
time ${com} 2>&1
