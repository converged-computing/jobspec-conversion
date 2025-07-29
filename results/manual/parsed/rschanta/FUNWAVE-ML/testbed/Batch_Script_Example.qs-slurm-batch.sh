#!/bin/bash
#SBATCH --job-name=ExampleBatchScript
#SBATCH --output=output.out
#SBATCH --error=error.out
#SBATCH --mail-user=rschanta@udel.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=thsu

	vpkg_require matlab
	vpkg_require openmpi
. /opt/shared/slurm/templates/libexec/openmpi.sh
	echo "Hello World!"
