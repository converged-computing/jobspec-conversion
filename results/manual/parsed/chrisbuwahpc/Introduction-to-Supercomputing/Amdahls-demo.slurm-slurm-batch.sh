#!/bin/bash
#SBATCH --job-name=darts-mpi
#SBATCH --account=courses01
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:20:00

echo "Running darts-mpi.x with 2 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 2 ./darts-mpi.x
echo "Running darts-mpi.x with 4 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 4 ./darts-mpi.x
echo "Running darts-mpi.x with 8 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 8 ./darts-mpi.x
echo "Running darts-mpi.x with 16 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 16 ./darts-mpi.x
