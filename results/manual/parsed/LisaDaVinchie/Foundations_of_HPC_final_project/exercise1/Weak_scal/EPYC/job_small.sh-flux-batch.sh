#!/bin/bash
#FLUX: --job-name="Weak_scal"
#FLUX: -N=2
#FLUX: -n=4
#FLUX: --exclusive
#FLUX: --queue=EPYC
#FLUX: -t=7200
#FLUX: --priority=16

export OMP_PLACES='cores'
export OMP_PROC_BIND='close'
export OMP_NUM_THREADS='$threads_per_socket'

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
matrix_dim_unit=10000
matrix_dim_fixed=10000
n_steps_min=50
n_steps_step=50
n_steps_max=150
threads_per_socket=64
max_procs=4
max_nodes=2
export OMP_PLACES=cores
export OMP_PROC_BIND=close
echo compile c file
mpicc -fopenmp -DTIME -o $execname $filename $libname
echo file compiled, executable is $execname
echo set maximum number of threads
export OMP_NUM_THREADS=$threads_per_socket
for n_procs in $(seq 1 1 $max_procs)
do
    matrix_dim=$((matrix_dim_unit*n_procs))
    # echo initialising playground for matrix dimension $matrix_dim
    # mpirun -np $max_procs --map-by socket ./$execname -i -x $matrix_dim_fixed -y $matrix_dim -f "${imagename}_${matrix_dim}.pgm"
    export OMP_NUM_THREADS=$((threads_per_socket*n_procs)) 
    mpirun -np $n_procs --map-by socket ./$execname -r -f "${imagename}_${matrix_dim}.pgm" -e 1 -n $n_steps_min -s $n_steps_min
done
echo removing modules
module purge
echo modules removed
echo removing executable
rm -rf $execname
echo executable removed
