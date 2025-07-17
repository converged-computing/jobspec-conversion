#!/bin/bash
#FLUX: --job-name=InstallCode
#FLUX: -n=10
#FLUX: --queue=normal
#FLUX: -t=1800
#FLUX: --urgency=16

module load numlib/GSL/2.7-GCC-11.3.0
module load toolchain/intel/2022.00
module load compiler/GCC/11.2.0
module load devel/CMake/3.18.4-GCCcore-10.2.0
module load mpi/OpenMPI/4.0.5-GCC-10.2.0
./GetModulesFromGit.sh
./CompileFramework.sh
