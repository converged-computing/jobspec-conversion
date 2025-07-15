#!/bin/bash
#FLUX: --job-name=omp_scale2
#FLUX: --exclusive
#FLUX: --queue=THIN
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export MPIRUN_OPTIONS='--bind-to core --map-by socket:PE=${SLURM_CPUS_PER_TASK} -report-bindings'
export OMP_NUM_THREADS='${SLURM_CPUS_PER_TASK}'

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
module load "${MPI_MODULE}"
mpirun -np 1 make all
export OMP_PLACES=cores
export OMP_PROC_BIND=close
export MPIRUN_OPTIONS="--bind-to core --map-by socket:PE=${SLURM_CPUS_PER_TASK} -report-bindings"
export OMP_NUM_THREADS=${SLURM_CPUS_PER_TASK}
now=$(date +"%Y-%m-%d_%H-%M-%S")
csvname=scale_omp_thin_$(hostname)_$now.csv
echo "$csvname $(hostname) $now"
echo "action,world_size,number_of_steps,number_of_steps_between_file_dumps,mpi_size,omp_get_max_threads,total_time,t_io,t_io_accumulator,t_io_accumulator_average" >"$csvname"
echo OMP scalability begin
for REP in {1..1}; do
  #  for SIZE in 10000; do
  if [ "$TYPE" == i ]; then
    #SIZE=10000
    for threads in {1..32}; do
      echo rep "$REP" scalability -i "$SIZE" "$threads"
      export OMP_NUM_THREADS=$threads
      mpirun -n 1 --map-by socket gameoflife.x -i -k "$SIZE" -f pattern_random"$SIZE" -q >>"$csvname"
    done
  else
    for threads in {1..12}; do
      echo rep "$REP" scalability -e"$TYPE" "$SIZE" "$threads"
      export MPIRUN_OPTIONS="--bind-to core --map-by socket:PE=$threads -report-bindings"
      export OMP_NUM_THREADS=$threads
      export OMP_DISPLAY_ENV=true
      export OMP_DISPLAY_AFFINITY=true
      #export NUM_CORES=${SLURM_NTASKS}*"$threads"
      echo "${EXECUTABLE} running on ${NUM_CORES} cores with ${SLURM_NTASKS} MPI-tasks and ${OMP_NUM_THREADS} threads"
      startexe="mpirun -n ${SLURM_NTASKS} ${MPIRUN_OPTIONS} ${EXECUTABLE} -r -f pattern_random$SIZE.pgm -n $STEPS -e $TYPE -s $SNAPAT -q"
      echo "$startexe"
      {
        #exec $startexe
        mpirun -n "${SLURM_NTASKS}" "${MPIRUN_OPTIONS}" "${EXECUTABLE}" -r -f pattern_random"$SIZE".pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -n 1 --map-by socket --report-bindings gameoflife.x -r -f pattern_random"$SIZE".pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -n 1 --map-by node --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -N 1 -n 1 --map-by socket --bind-to socket --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -np 2 --map-by socket --bind-to socket --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -np 2 --map-by socket:PE=$threads --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
        #mpirun -n 1 --map-by socket --display-map --report-bindings gameoflife.x -r -f pattern_random$SIZE.pgm -n $STEPS -e "$TYPE" -s "$SNAPAT" -q
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
