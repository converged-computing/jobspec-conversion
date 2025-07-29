#!/bin/bash
#SBATCH --job-name=benchmark
#SBATCH --account=m1503
#SBATCH --output=benchmark.o%j
#SBATCH --nodes=32
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --licenses=SCRATCH

prefix='relax'
currindex=1
source $MODULESHOME/init/bash
module load lammps/20161117
lmp=lmp_edison
echo "LAMMPS executable is $lmp"
cd $SLURM_SUBMIT_DIR
srun -n 768  $lmp -in benchmark_NVT.in # Do not use "<" in place of "-in"
