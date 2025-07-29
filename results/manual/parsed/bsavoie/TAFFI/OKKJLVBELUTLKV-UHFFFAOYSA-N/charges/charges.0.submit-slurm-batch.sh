#!/bin/bash
#FLUX: --job-name=charges.0
#FLUX: -n=24
#FLUX: -t=14400
#FLUX: --urgency=16

echo Running on hosts: $SLURM_NODELIST
echo Running on $SLURM_NNODES nodes.
echo "Running on \$SLURM_NPROCS processors."
echo "Current working directory is `pwd`"
echo "Copying input file to scratch..."
cd .
mpirun -np 24 /depot/bsavoie/apps/lammps/exe/lmp_mpi_180501 -in charges.in.init >> charges.in.out &
cd /scratch/brown/seo89/linear_molecules/nitrogen_new/OKKJLVBELUTLKV-UHFFFAOYSA-N/charges
wait
