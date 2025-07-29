#!/bin/bash
#SBATCH --job-name=galsim-mpi-forecast
#SBATCH --output=mpi-output/galsim-%j.out
#SBATCH --error=mpi-output/galsimMPI-%j.out
#SBATCH --nodes=3
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00

GALSIM_DIR=/users/jmcclear/data/superbit/superbit-metacal/GalSim
CONFIG_FILE=$GALSIM_DIR/superbit_parameters_debugforecast.yaml
srun --mpi=pmix python $GALSIM_DIR/mock_superBIT_data.py config_file=$CONFIG_FILE
