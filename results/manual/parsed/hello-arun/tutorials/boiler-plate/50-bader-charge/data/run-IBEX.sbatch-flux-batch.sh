#!/bin/bash
#FLUX: --job-name="__jobName"
#FLUX: --queue=batch
#FLUX: -t=9000
#FLUX: --priority=16

export VASP_HOME='/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin'
export OMP_NUM_THREADS='1'
export SLURM_NTASKS='$((SLURM_NNODES*SLURM_NTASKS_PER_NODE))'

module load intel/2016
module load openmpi/4.0.3_intel
module load perl
export VASP_HOME=/ibex/scratch/jangira/vasp/sw/vasp.5.4.4/bin
export OMP_NUM_THREADS=1
export SLURM_NTASKS=$((SLURM_NNODES*SLURM_NTASKS_PER_NODE))
echo """
                MACHINE: IBEX
           SLURM_NODEID: ${SLURM_NODEID}
         SLURM_NODELIST: ${SLURM_NODELIST}
           SLURM_NNODES: ${SLURM_NNODES}
           SLURM_NTASKS: ${SLURM_NTASKS}
           SLURM_NPROCS: ${SLURM_NPROCS}
  SLURM_NTASKS_PER_CORE: ${SLURM_NTASKS_PER_CORE}
   SLURM_NTASKS_PER_GPU: ${SLURM_NTASKS_PER_GPU}
  SLURM_NTASKS_PER_NODE: ${SLURM_NTASKS_PER_NODE}
SLURM_NTASKS_PER_SOCKET: ${SLURM_NTASKS_PER_SOCKET}
"""
mpirun -np ${SLURM_NTASKS} ${VASP_HOME}/vasp_std    # For Standard Calc
perl chgsum.pl AECCAR0 AECCAR2
chmod +x ./bader
./bader CHGCAR -ref CHGCAR_sum
module purge 
