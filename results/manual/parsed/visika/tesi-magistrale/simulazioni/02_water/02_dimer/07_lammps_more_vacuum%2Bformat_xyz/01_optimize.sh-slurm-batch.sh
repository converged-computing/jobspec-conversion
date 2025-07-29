#!/bin/bash
#SBATCH --job-name=dimer
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --constraint=ntasks-per-node=1

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
