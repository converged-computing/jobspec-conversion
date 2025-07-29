#!/bin/bash
#SBATCH --job-name=SED
#SBATCH --output=outfile_%J.vasp
#SBATCH --error=errfile_%J.vasp
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --partition=amd_512

export PATH='/public3/home/scg5426/lammps/new/lammps-3Aug2022/src:$PATH'

run_lammps_file="in.vels"
source /public3/soft/modules/module.sh
module load mpi/intel/20.0.4-ls
export PATH=/public3/home/scg5426/lammps/new/lammps-3Aug2022/src:$PATH
mpirun -np 64 lmp_intel_cpu_intelmpi -in ${run_lammps_file}
