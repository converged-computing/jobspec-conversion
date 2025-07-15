#!/bin/bash
#FLUX: --job-name=setupbuii
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_PROC_BIND='spread'
export OMP_PLACES='threads'

module load gcc/11.2.0-gcc-11.2.0
module load python3/2022.01-gcc-11.2.0
module load nvhpc/23.7-gcc-11.2.0
spack load cmake@3.23.1%gcc
source activate /work/mh1126/m300950/condaenvs/superdropsenv
path2CLEO=${HOME}/CLEO/
path2src=${HOME}/breakup_partii/src/
path2build=/work/mh1126/m300950/droplet_breakup_partii/build/
orig_configfile=${HOME}/breakup_partii/src/src/buii_config.txt 
tmp_configfile=${path2build}/tmp/buii_config.txt 
python=/work/mh1126/m300950/condaenvs/superdropsenv/bin/python
gxx="g++"
gcc="gcc"
cuda="nvc++"
kokkosflags="-DKokkos_ARCH_NATIVE=ON -DKokkos_ARCH_AMPERE80=ON -DKokkos_ENABLE_SERIAL=ON" # serial kokkos
kokkoshost="-DKokkos_ENABLE_OPENMP=ON"                                          # flags for host parallelism (e.g. using OpenMP)
kokkosdevice=""           # flags for device parallelism (e.g. using CUDA)
buildcmd="CXX=${gxx} CC=${gcc} CUDA=${cuda} cmake -S ${path2src} -B ${path2build} ${kokkosflags} ${kokkoshost} ${kokkosdevice}"
echo ${buildcmd}
CXX=${gxx} CC=${gcc} CUDA=${cuda} cmake -S ${path2src} -B ${path2build} ${kokkosflags} ${kokkoshost} ${kokkosdevice} -DCLEOLIBS_SOURCE_DIR:STRING=${path2CLEO}libs
export OMP_PROC_BIND=spread
export OMP_PLACES=threads
${python} build_buii.py ${path2CLEO} ${path2build} ${orig_configfile} ${tmp_configfile} 
