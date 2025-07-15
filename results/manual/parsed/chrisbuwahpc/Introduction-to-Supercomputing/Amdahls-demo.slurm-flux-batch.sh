#!/bin/bash
#FLUX: --job-name=darts-mpi
#FLUX: -t=1200
#FLUX: --urgency=16

echo "Running darts-mpi.x with 2 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 2 ./darts-mpi.x
echo "Running darts-mpi.x with 4 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 4 ./darts-mpi.x
echo "Running darts-mpi.x with 8 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 8 ./darts-mpi.x
echo "Running darts-mpi.x with 16 MPI-tasks"
/usr/bin/time -f "Elapsed time = %E" aprun -n 16 ./darts-mpi.x
