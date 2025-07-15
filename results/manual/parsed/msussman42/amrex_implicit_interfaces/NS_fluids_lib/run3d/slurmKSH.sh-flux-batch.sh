#!/bin/bash
#FLUX: --job-name=1_150
#FLUX: --exclusive
#FLUX: --queue=engineering_q
#FLUX: --urgency=16

pwd;hostname;date
echo "running amrMPI (FABRIC) on $SLURM_JOB_NUM_NODES nodes with $SLURM_NTASKS tasks, each with $SLURM_CPUS_PER_TASK cores."
 module purge
 module load gnu/11.2.1
 module load openmpi
srun /gpfs/research/engineering/Kshoele/FabricDrop_New_20240120/amrex_implicit_interfaces/NS_fluids_lib/amr3d.gnu.FLOAT.MPI.ex inputs.FABRIC_DROP
