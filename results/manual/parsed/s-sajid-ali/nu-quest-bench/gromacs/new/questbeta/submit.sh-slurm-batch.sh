#!/bin/bash
#SBATCH --job-name=test_mpi
#SBATCH --account=p30157
#SBATCH --output=outlog
#SBATCH --error=errlog
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00
#SBATCH --constraint=ntasks-per-node=24

source /home/sas4990/packages/spack/share/spack/setup-env.sh
module purge all
BASE_DIR=$(pwd)
rm -rf questbeta
mkdir questbeta
for i in sfwpwj3
do
    cd $BASE_DIR
    spack load --dependencies /$i
    export OMP_NUM_THREADS=1
    for run in {1..5}
    do
	    srun --mpi=pmi2 gmx_mpi mdrun -s lignocellulose-rf.tpr -maxh 0.5 -resethway -noconfout -nsteps 10000 -g </dev/null &> log_$run
    done
done 
