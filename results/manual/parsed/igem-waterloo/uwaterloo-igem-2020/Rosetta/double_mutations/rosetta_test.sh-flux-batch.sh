#!/bin/bash
#FLUX: --job-name=rosetta_test
#FLUX: -t=36000
#FLUX: --priority=16

ROSETTA3="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/rosetta/3.10"
ROSETTA3_DB="/cvmfs/soft.computecanada.ca/easybuild/software/2017/avx2/MPI/intel2016.4/openmpi2.1/rosetta/3.10/database"
module load nixpkgs/16.09  gcc/7.3.0  openmpi/3.1.2 rosetta/3.10
$ROSETTA3/bin/pmut_scan_parallel.mpi.linuxiccrelease -in:file:s 5icu_HETATM_relaxed.pdb @pmut.flags
