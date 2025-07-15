#!/bin/bash
#FLUX: --job-name="mpi_scale"
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'

TYPE="i"
STEPS=100
SNAPAT=0
if [ $# == 1 ]; then
  TYPE="$1"
fi
if [ $# == 2 ]; then
  TYPE="$1"
  SNAPAT="$2"
fi
if [ $# == 3 ]; then
  TYPE="$1"
  SNAPAT="$2"
  SIZE="$3"
fi
echo "Selected type of execution: $TYPE"
module load openMPI/4.1.5/gnu/12.2.1
mpirun -np 1 make all
export OMP_PLACES=cores
export OMP_PROC_BIND=close
now=$(date +"%Y-%m-%d_%H-%M-%S")
csvname=scale_mpi_epyc_$(hostname)_$now.csv
echo "$csvname $(hostname) $now"
echo "action,world_size,number_of_steps,number_of_steps_between_file_dumps,mpi_size,omp_get_max_threads,total_time,t_io,t_io_accumulator,t_io_accumulator_average" >"$csvname"
echo MPI scalability begin
for REP in {1..10}; do
  #  for SIZE in 10000 1000 100; do
  if [ "$TYPE" == i ]; then
    for threads in {1..64}; do
      echo rep "$REP" scalability -i "$SIZE" "$threads"
      mpirun -np "$threads" --map-by core gameoflife.x -i -k "$SIZE" -f pattern_random"$SIZE" -q >>"$csvname"
    done
  else
    for threads in {54..256}; do
      echo rep "$REP" scalability -e"$TYPE" "$SIZE" "$threads"
      {
        mpirun -np "$threads" --map-by core gameoflife.x -r -f pattern_random"$SIZE".pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -np "$threads" --map-by core --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #      mpirun -n 1 --map-by node gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e 0 -s 0 -q
        #      mpirun -n 1 --map-by node gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e 1 -s 0 -q
        #      mpirun -n 1 --map-by node gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e 2 -s 0 -q
        #      mpirun -n 1 --map-by node gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e 3 -s 0 -q
      } >>"$csvname"
    done
  fi
  #  done
done
echo scalability end
