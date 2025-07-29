#!/bin/bash
#SBATCH --job-name=quickStart
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=ntasks-per-node=4

export OMP_NUM_THREADS='4'

module purge
module load python/3.6.5 intel impi R/3.5.0 
ls
cd $SLURM_SUBMIT_DIR
echo "**** running our parallel Fortran example"
mpirun -n 8 ./hellof > hellof.out
echo "**** running our parallel C example"
mpirun -n 8 ./helloc > helloc.out
echo "**** running our hybrid MPI/OpenMP C example"
export OMP_NUM_THREADS=2
mpirun -n 8 ./phostone -F > phostone.out
echo "**** running our OpenMP Fortran example"
export OMP_NUM_THREADS=4
./invertf > invertf.out
echo "**** running our OpenMP C example"
export OMP_NUM_THREADS=4
./invertc > invertc.out
./tymer timefile "**** running our R example"
Rscript invert.R
./tymer timefile "end R"
./tymer timefile "**** running our python example"
python3 invert.py
./tymer timefile "end python"
