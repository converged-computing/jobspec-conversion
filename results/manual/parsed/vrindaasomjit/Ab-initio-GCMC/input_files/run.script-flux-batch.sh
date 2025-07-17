#!/bin/bash
#FLUX: --job-name=gcmc
#FLUX: -N=4
#FLUX: -n=182
#FLUX: --queue=skx-dev
#FLUX: -t=7200
#FLUX: --urgency=16

export LAMMPS_DIR='/home1/04770/tg840694/help_TACC_lammps/stable_3Mar2020_clean/'
export PATH='${PATH}:${LAMMPS_DIR}/bin'
export PYTHONPATH='${PYTHONPATH}:${LAMMPS_DIR}/lib/message/cslib/src'
export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:${LAMMPS_DIR}/lib/message/cslib/src'

module reset
module load intel/18.0.2
module load impi/18.0.2
module load python2/2.7.15
module load vasp/5.4.4
module unload mistral/2.13.4
ml
export LAMMPS_DIR=/home1/04770/tg840694/help_TACC_lammps/stable_3Mar2020_clean/
export PATH=${PATH}:${LAMMPS_DIR}/bin
which lmp_stampede
export PYTHONPATH=${PYTHONPATH}:${LAMMPS_DIR}/lib/message/cslib/src
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${LAMMPS_DIR}/lib/message/cslib/src
ibrun -n 1 -o 0 lmp_stampede -v mode file < in.client.intf &
python vasp_wrap_gcmc.py file POSCARintf &
wait
