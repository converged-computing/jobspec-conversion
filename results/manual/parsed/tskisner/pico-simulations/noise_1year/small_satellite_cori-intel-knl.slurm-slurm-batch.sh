#!/bin/bash
#SBATCH --job-name=small-satellite
#SBATCH --account=mp107
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=knl,quad,cache

export OMP_NUM_THREADS='${node_thread}'
export OMP_PLACES='threads'
export OMP_PROC_BIND='spread'
export TMPDIR='/dev/shm'

echo Starting slurm script at $(date)
echo -e "\n-----------------------------------------------------------------------"
echo -e "ENVIRONMENT:\n"
env
echo -e "-----------------------------------------------------------------------\n"
echo "PYTHON: $(which python)"
echo "PYTHON VERSION: $(python --version &> /dev/stdout)"
echo ""
pstr=cori-intel-knl
outdir="out_small_satellite_${pstr}"
mkdir -p "${outdir}"
nodes=1
nobs=2
if [ $nobs -lt 50 ]; then
    node_proc=1
else
    node_proc=16
fi
detpix=1
fpfile="pico_1.pkl"
if [ ! -e "${fpfile}" ]; then
    srun -n 1 -N 1 bash make_focalplane.sh
fi
source env_knl.sh
ex=$(which toast_satellite_sim.py)
echo "Using ${ex}"
parfile="pico_scanning.par"
nside=1024
groupnodes=0
if [ ${node_proc} -gt ${detpix} ]; then
    groupsize=1
else
    groupsize=$(( node_proc * groupnodes ))
fi
com="${ex} @${parfile} \
--groupsize ${groupsize} \
--fp ${fpfile} \
--nside ${nside} \
--numobs ${nobs} \
--madam \
--noisefilter \
--baseline 1.0 \
--outdir ${outdir}/out \
"
cpu_per_core=4
node_cores=64
node_thread=$(( node_cores / node_proc ))
node_depth=$(( cpu_per_core * node_thread ))
procs=$(( nodes * node_proc ))
export OMP_NUM_THREADS=${node_thread}
export OMP_PLACES=threads
export OMP_PROC_BIND=spread
export TMPDIR=/dev/shm
run="srun --cpu_bind=cores -n ${procs} -N ${nodes} -c ${node_depth}"
echo Calling srun at $(date)
echo "${run} ${com}"
eval ${run} ${com} > "${outdir}/log" 2>&1
echo End slurm script at $(date)
