#!/bin/bash
#SBATCH --nodes=1			# Number of requested nodes
#SBATCH --ntasks=4			# Number of requested cores
#SBATCH --time=0:01:00			# Max walltime
#SBATCH --qos=normal	      		# Specify QOS
#SBATCH --partition=shas		# Specify Summit haswell nodes
#SBATCH --output=python_%j.out		# Output file name
#SBATCH --reservation=tutorial1		# Reservation (only valid during workshop)


# Written by:	Andrew Monaghan, 08 March 2018
# Updated by:	Shelley Knuth, 17 May 2019
# Purpose: 	To demonstrate how to submit an MPI python job 

# purge all existing modules
module purge

# Load the python module
module load python/3.5.1
module load intel impi   

# Run Python Script
cd progs
mpirun -np $SLURM_NTASKS python hello1.py
