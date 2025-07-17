#!/bin/bash
#FLUX: --job-name=hairy-buttface-5936
#FLUX: -N=3
#FLUX: -n=96
#FLUX: -t=255600
#FLUX: --urgency=16

echo "Date              = $(date)"
echo "Hostname          = $(hostname -s)"
echo "Working Directory = $(pwd)"
echo ""
echo "Number of Nodes Allocated      = $SLURM_JOB_NUM_NODES"
echo "Number of Tasks Allocated      = $SLURM_NTASKS"
echo "Number of Cores/Task Allocated = $SLURM_CPUS_PER_TASK"
echo "Lammps version used = 20220623      https://github.com/lammps/lammps/archive/patch_23Jun2022.tar.gz"
echo "Openmpi version used = 4.1.4     https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.4.tar.bz2"
. /usr/share/spack/root/share/spack/setup-env.sh
spack load lammps@20220623
spack load openmpi@4.1.4
mpirun lmp -i in.Mo_cascade
