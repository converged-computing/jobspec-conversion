#!/bin/bash
#FLUX: --job-name=OpenMP_scal
#FLUX: -c=64
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --urgency=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export OMP_NUM_THREADS='$max_threads'

echo Load Modules
module load architecture/AMD
module load openMPI/4.1.5/gnu/12.2.1
echo set topology
data_folder=$(pwd)
program_folder=../../program
echo data folder is $data_folder
filename="$program_folder/game_of_life_parallel_v3.c"
execname=game_of_life_parallel_v3.exe
libname="$program_folder/parallel_lib_v3.c"
imagename="playground"
matrix_dim_min=10000
matrix_dim_step=5000
matrix_dim_max=20000
n_steps_min=50
n_steps_step=50
n_steps_max=150
max_threads=64
max_processes=1
export OMP_PLACES=cores
export OMP_PROC_BIND=close
echo compile c file
mpicc -fopenmp -DTIME -o $execname $filename $libname
echo file compiled, executable is $execname
echo set maximum number of threads
export OMP_NUM_THREADS=$max_threads
matrix_dim=20000
    for n_threads in $(seq 24 1 $max_threads)
    do
        export OMP_NUM_THREADS=$n_threads
        for idx in $(seq 1 1 5)
        do
            mpirun -np $max_processes --map-by socket ./$execname -r -f "${imagename}_${matrix_dim}.pgm" -e 1 -n $n_steps_min -s $n_steps_min
        done
    done
echo removing modules
module purge
echo modules removed
echo removing executable
rm -rf $execname
echo executable removed
