#!/bin/bash
#SBATCH --job-name=lackey
#SBATCH --output=lackey4_%j.out
#SBATCH --error=lackey4_%j.err
#SBATCH --nodes=4
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=17:05:00
#SBATCH --chdir=.

export OMP_NUM_THREADS='1'

x=$1
export OMP_NUM_THREADS=48
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 1 /usr/bin/time -v ./nest $x &>> n4_1.txt
export OMP_NUM_THREADS=24
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 2 /usr/bin/time -v  ./nest $x &>> n4_2.txt
export OMP_NUM_THREADS=16
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 3 /usr/bin/time -v ./nest $x &>> n4_3.txt
export OMP_NUM_THREADS=12
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 4 /usr/bin/time -v  ./nest $x  &>> n4_4.txt
export OMP_NUM_THREADS=8
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 6 /usr/bin/time -v ./nest $x  &>> n4_6.txt
export OMP_NUM_THREADS=6
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 8 /usr/bin/time -v ./nest $x &>> n4_8.txt
export OMP_NUM_THREADS=4
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 12 /usr/bin/time -v ./nest $x  &>> n4_12.txt
export OMP_NUM_THREADS=3
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 16 /usr/bin/time -v  ./nest $x  &>> n4_16.txt
export OMP_NUM_THREADS=2
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 24 /usr/bin/time -v ./nest $x  &>> n4_24.txt
export OMP_NUM_THREADS=1
valgrind --tool=lackey --basic-counts=yes --trace-mem=yes  mpirun -n 48 /usr/bin/time -v ./nest $x &>> n4_48.txt
exit
