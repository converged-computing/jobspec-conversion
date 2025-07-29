#!/bin/bash
#SBATCH --job-name=rosetta_test
#SBATCH --account=def-bingalls
#SBATCH --output=%x-%j.out
#SBATCH --mail-user=jj5song@uwaterloo.ca
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=128000
#SBATCH --time=10:00:00

ROSETTA3="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/rosetta/3.10"
ROSETTA3_DB="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/rosetta/3.10/database"
module load nixpkgs/16.09  gcc/7.3.0  openmpi/3.1.2 rosetta/3.10
$ROSETTA3/bin/pmut_scan_parallel.mpi.linuxiccrelease -in:file:s 5icu_HETATM_relaxed.pdb @pmut.flags
