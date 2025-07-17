#!/bin/bash
#FLUX: --job-name=angry-cherry-1406
#FLUX: --queue=stem
#FLUX: -t=5400
#FLUX: --urgency=16

module load lammps-31Jan14
module load compile/intel
module load mpi/intel/openmpi-1.10.2
python $STRUCTOPT_HOME/structopt/optimizers/genetic.py structopt.in.json 
