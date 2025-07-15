#!/bin/bash
#FLUX: --job-name=vib
#FLUX: --queue=sequential
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'
export MKL_NUM_THREADS='1'
export VASP='/lustre/home/tccourse/vasp46-da/vasp'
export VASPGAMMA='/lustre/home/tccourse/vasp46-da.gamma/vasp'
export PHON='/lustre/home/tccourse/Phon/src/phon'
export RUNPHON='$SLURM_SUBMIT_DIR/runphon'

ulimit -s unlimited
export OMP_NUM_THREADS=2
export MKL_NUM_THREADS=1
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
python 04_vib_write.py
echo "FINISHED!!!"
rm $ALERT
