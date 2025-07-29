#!/bin/bash
#SBATCH --job-name=test_mpi
#SBATCH --output=res_mpi.txt
#SBATCH --error=err_mpi.txt
#SBATCH --nodes=6
#SBATCH --ntasks=6
#SBATCH --cpus-per-task=5
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=10G
#SBATCH --time=00:20:00

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
