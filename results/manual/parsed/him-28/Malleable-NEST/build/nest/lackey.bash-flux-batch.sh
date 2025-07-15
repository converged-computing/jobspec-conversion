#!/bin/bash
#FLUX: --job-name=lackey
#FLUX: -n=48
#FLUX: -t=61500
#FLUX: --priority=16

export OMP_NUM_THREADS='1'

x=$1
export OMP_NUM_THREADS=48
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 1 /usr/bin/time -v ./nest $x &>> n1_1.txt
export OMP_NUM_THREADS=24
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 2 /usr/bin/time -v  ./nest $x &>> n1_2.txt
export OMP_NUM_THREADS=16
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 3 /usr/bin/time -v ./nest $x &>> n1_3.txt
export OMP_NUM_THREADS=12
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 4 /usr/bin/time -v  ./nest $x  &>> n1_4.txt
export OMP_NUM_THREADS=8
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 6 /usr/bin/time -v ./nest $x  &>> n1_6.txt
export OMP_NUM_THREADS=6
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 8 /usr/bin/time -v ./nest $x &>> n1_8.txt
export OMP_NUM_THREADS=4
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 12 /usr/bin/time -v ./nest $x  &>> n1_12.txt
export OMP_NUM_THREADS=3
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 16 /usr/bin/time -v  ./nest $x  &>> n1_16.txt
export OMP_NUM_THREADS=2
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 24 /usr/bin/time -v ./nest $x  &>> n1_24.txt
export OMP_NUM_THREADS=1
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 48 /usr/bin/time -v ./nest $x &>> n1_48.txt
exit
