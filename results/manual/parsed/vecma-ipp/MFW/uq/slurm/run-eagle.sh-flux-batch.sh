#!/bin/bash
#FLUX: --job-name=mfw_uq
#FLUX: --queue=fast
#FLUX: -t=3600
#FLUX: --urgency=16

export SYS='EAGLE'
export MPICMD='mpirun'
export MODULEPATH='$MODULEPATH:/home/plgrid-groups/plggvecma/.qcg-modules'
export SCRATCH='$PLG_USER_SCRATCH/plgljala'
export PYTHONPATH='$PYTHONPATH:$HOME/workspace/mfw/ual/usr'
export EASYPJ_CONFIG='conf.sh'

export SYS=EAGLE
export MPICMD=mpirun
export MODULEPATH=$MODULEPATH:/home/plgrid-groups/plggvecma/.qcg-modules
export SCRATCH=$PLG_USER_SCRATCH/plgljala
export PYTHONPATH=$PYTHONPATH:$HOME/workspace/mfw/ual/usr
ENCODER_MODULES="mfw.templates.cpo_encoder;mfw.templates.xml_encoder"
export ENCODER_MODULES
export EASYPJ_CONFIG=conf.sh
module load python/3.7.3
module load ifort
module load impi
module load fftw
module unload gcc
module unload gmp
python3.7 tests/loop_src_pj.py > log-trace.${SLURM_JOBID}
