#!/bin/bash
#FLUX: --job-name=kT0.007
#FLUX: -c=20
#FLUX: --queue=secondary
#FLUX: -t=14400
#FLUX: --urgency=16

export ASE_LAMMPSRUN_COMMAND='/home/krongch2/projects/lammps/lammps/src/lmp_mpi'

echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
export ASE_LAMMPSRUN_COMMAND=/home/krongch2/projects/lammps/lammps/src/lmp_mpi
python -u kc.py -kT 0.007
