#!/bin/bash
#FLUX: --job-name=dimer
#FLUX: -c=4
#FLUX: --queue=parallel
#FLUX: --urgency=16

export VASP='/lustre/home/tccourse/vasp46-da/vasp'
export VASPGAMMA='/lustre/home/tccourse/vasp46-da.gamma/vasp'
export PHON='/lustre/home/tccourse/Phon/src/phon'
export RUNPHON='$SLURM_SUBMIT_DIR/runphon'

ulimit -s unlimited
export VASP="/lustre/home/tccourse/vasp46-da/vasp"
export VASPGAMMA="/lustre/home/tccourse/vasp46-da.gamma/vasp"
export PHON="/lustre/home/tccourse/Phon/src/phon"
export RUNPHON="$SLURM_SUBMIT_DIR/runphon"
cd "$SLURM_SUBMIT_DIR" || exit
ALERT=000-THIS_IS_RUNNING
touch $ALERT
source /lustre/home/mmollo/setupconda.sh
conda activate mmollo-lammps-env
echo Using "$(python -V)"
python 01_optimize.py
echo "FINISHED!!!"
rm $ALERT
