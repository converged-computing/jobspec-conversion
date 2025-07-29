#!/bin/bash
#SBATCH --job-name=mfw_uq
#SBATCH --account=vecma2020
#SBATCH --output=log-out.%j
#SBATCH --error=log-err.%j
#SBATCH --mail-user=jalal.lakhlili@ipp.mpg.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

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
