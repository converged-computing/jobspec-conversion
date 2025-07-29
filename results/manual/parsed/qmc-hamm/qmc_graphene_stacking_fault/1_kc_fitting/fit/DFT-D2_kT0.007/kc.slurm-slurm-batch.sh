#!/bin/bash
#FLUX: --job-name=fit/DFT-D2_kT0.007
#FLUX: -c=20
#FLUX: --queue=physics
#FLUX: -t=50400
#FLUX: --urgency=16

export ASE_LAMMPSRUN_COMMAND='/home/krongch2/projects/lammps/lammps/src/lmp_mpi'

echo $SLURM_SUBMIT_DIR
cd $SLURM_SUBMIT_DIR
export ASE_LAMMPSRUN_COMMAND=/home/krongch2/projects/lammps/lammps/src/lmp_mpi
python -u kc.py --method DFT-D2 -kT 0.007
