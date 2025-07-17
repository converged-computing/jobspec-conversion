#!/bin/bash
#FLUX: --job-name=premd_100nM_Na_Aqvist
#FLUX: -n=64
#FLUX: --queue=work
#FLUX: -t=86400
#FLUX: --urgency=16

export OMP_NUM_THREADS='1'
export FI_CXI_DEFAULT_VNI='$(od -vAn -N4 -tu < /dev/urandom)'

module load slurm
echo "The current job ID is $SLURM_JOB_ID"
echo "Running on $SLURM_JOB_NUM_NODES nodes"
echo "Using $SLURM_NTASKS_PER_NODE tasks per node"
echo "A total of $SLURM_NTASKS tasks is used"
echo "Node list:"
sacct --format=JobID,NodeList%100 -j $SLURM_JOB_ID
module load gromacs/2023
export OMP_NUM_THREADS=1
export FI_CXI_DEFAULT_VNI=$(od -vAn -N4 -tu < /dev/urandom)
srun -N $SLURM_JOB_NUM_NODES -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -m block:block:block gmx_mpi_d mdrun -dlb yes -deffnm premd1
srun -N 1 -n 1 -c 1 gmx_mpi_d grompp -f premd2.mdp -c premd1.gro -p L21hybrid_bilayer_topol.top -n index.ndx -o premd2.tpr
srun -N $SLURM_JOB_NUM_NODES -n $SLURM_NTASKS -c $SLURM_CPUS_PER_TASK -m block:block:block gmx_mpi_d mdrun -dlb yes -deffnm premd2
