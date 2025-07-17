#!/bin/bash
#FLUX: --job-name=gromacs-benchPEP
#FLUX: -N=64
#FLUX: -c=4
#FLUX: --queue=standard
#FLUX: -t=86400
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}'
export PATH='/work/z19/z19/wlucas/cug22-bench/sw/gromacs/2021.5/bin:${PATH}'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

module load cpe/21.09
module swap PrgEnv-cray PrgEnv-gnu
module swap craype-network-ofi craype-network-ucx
module swap cray-mpich cray-mpich-ucx
export LD_LIBRARY_PATH=${CRAY_LD_LIBRARY_PATH}:${LD_LIBRARY_PATH}
export PATH=/work/z19/z19/wlucas/cug22-bench/sw/gromacs/2021.5/bin:${PATH}
module list
nruns=3
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
for irun in $(seq 1 ${nruns})
do
   timestamp=$(date +%s)
   srun --distribution=block:block --hint=nomultithread gmx_mpi mdrun -s ../benchPEP.tpr -g benchPEP_UCX_${nnodes}nodes_${SLURM_CPUS_PER_TASK}threads_run${irun}_id${SLURM_JOB_ID}_${timestamp}.log -nsteps 10000 -noconfout &> slurm_benchPEP_UCX_${SLURM_JOB_NUM_NODES}nodes_${SLURM_CPUS_PER_TASK}threads_run${irun}_id${SLURM_JOB_ID}_${timestamp}.out
done
