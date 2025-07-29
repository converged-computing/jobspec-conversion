#!/bin/bash
#FLUX: --job-name=test_mpi
#FLUX: -N=6
#FLUX: -n=6
#FLUX: -c=5
#FLUX: --queue=batch
#FLUX: -t=1200
#FLUX: --urgency=16

{
	set -e
	module purge
	module load openmpi
	mpicc wiki.c -o wiki
	sbatch <<- EOF
	#!/bin/bash
	# srun --nodes=3 --ntasks=3 \
	# ./wiki &
	# srun --nodes=2 --ntasks=2 \
	# ./wiki &
	# srun --nodes=3 --ntasks=3 --mpi pmi2 \
	# ./wiki &
	# srun --nodes=2 --ntasks=2 --mpi pmi2 \
	# ./wiki &
	# mpirun -n 3 \
	# ./wiki &
	# mpirun -n 2 \
	# ./wiki &
	srun --nodes=3 --ntasks=3 \
	python wikipy.py
	wait
	EOF
}
