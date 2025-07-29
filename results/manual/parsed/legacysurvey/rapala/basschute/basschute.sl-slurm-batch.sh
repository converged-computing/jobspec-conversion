#!/bin/bash
#SBATCH --job-name=basschute
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:30:00
#SBATCH --partition=regular

export XARGS='--maxmem $MAXMEM $XARGS'

cd $SLURM_SUBMIT_DIR   # optional, since this is the default behavior
if [ "$NERSC_HOST" == "edison" ]
then
	if [[ -z "$NPROC" ]]; then
		export NPROC=24
	fi
	export MAXMEM=50
fi
if [ "$NERSC_HOST" == "cori" ]
then
	if [[ -z "$NPROC" ]]; then
		export NPROC=32
	fi
	export MAXMEM=100
fi
echo "redux dir is $BASSRDXDIR"
export XARGS="--maxmem $MAXMEM $XARGS"
srun -n 1 -c $NPROC make quickproc
