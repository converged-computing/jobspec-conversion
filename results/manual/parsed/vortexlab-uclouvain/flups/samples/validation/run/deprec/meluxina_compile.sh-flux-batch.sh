#!/bin/bash
#FLUX: --job-name=Flups Compilation
#FLUX: --queue=cpu
#FLUX: -t=600
#FLUX: --urgency=16

source ${MODULES} ${OMPIVERSION}
cd ${H3LPR_DIR}
touch make_arch/make.meluxina
echo "CC = mpicc " > make_arch/make.meluxina
echo "CXX = mpic++ " >> make_arch/make.meluxina 
echo "CXXFLAGS := -g -O3 -march=native -fopenmp -DNDEBUG " >> make_arch/make.meluxina
echo "LDFLAGS := -fopenmp -rdynamic -ldl " >> make_arch/make.meluxina
ARCH_FILE=make_arch/make.meluxina make install -j 
cd - 
cd ${FLUPS_DIR} 
echo "CXX = ${EBROOTOPENMPI}/bin/mpic++ " > make_arch/make.meluxina
echo "CC = ${EBROOTOPENMPI}/bin/mpicc " >> make_arch/make.meluxina
echo "# set the flag (optimisation or not) " >> make_arch/make.meluxina
echo "## For debugging: " >> make_arch/make.meluxina
echo "# CXXFLAGS := -g -Wall -O0 --debug -std=c++11 -DVERBOSE -DDUMP_DBG " >> make_arch/make.meluxina
echo "## For profiling: " >> make_arch/make.meluxina
echo "# CXXFLAGS := -O3 -g -DNDEBUG -std=c++11 -Wno-variadic-macros -DPROF " >> make_arch/make.meluxina
echo "## For production: " >> make_arch/make.meluxina
echo "CXXFLAGS := -g -O0 -DVERBOSE -std=c++17 -march=native -DHAVE_WISDOM=\\\"${HOME}/flups/fftw-wisdom/wisdom/meluxina.wsdm\\\" ${COMPILE_OPT}" >> make_arch/make.meluxina
echo "CCFLAGS := -g -O0 -DVERBOSE -std=c99 -march=native" >> make_arch/make.meluxina
echo "LDFLAGS = -fopenmp " >> make_arch/make.meluxina
echo "#---------------------------------------------------------   " >> make_arch/make.meluxina
echo "# DEPENDENCES DIRECTORIES  " >> make_arch/make.meluxina
echo "#---------------------------------------------------------  " >> make_arch/make.meluxina
echo "  " >> make_arch/make.meluxina
echo "## FFTW3  " >> make_arch/make.meluxina
echo "FFTW_DIR  := ${EBROOTFFTW}  " >> make_arch/make.meluxina
echo "FFTW_LIB := ${EBROOTFFTW}/lib  " >> make_arch/make.meluxina
echo "FFTW_INC := ${EBROOTFFTW}/include  " >> make_arch/make.meluxina
echo "  " >> make_arch/make.meluxina
echo "## HDF5  " >> make_arch/make.meluxina
echo "HDF5_DIR  := ${EBROOTHDF5}  " >> make_arch/make.meluxina
echo "HDF5_LIB := ${EBROOTHDF5}/lib  " >> make_arch/make.meluxina
echo "HDF5_INC := ${EBROOTHDF5}/include  " >> make_arch/make.meluxina
echo "  " >> make_arch/make.meluxina
echo "##H3LPR  " >> make_arch/make.meluxina
echo "H3LPR_INC := ${H3LPR_DIR}/include/  " >> make_arch/make.meluxina
echo "H3LPR_LIB := ${H3LPR_DIR}/lib/  " >> make_arch/make.meluxina
ARCH_FILE=make_arch/make.meluxina make install_static -j
cd - 
cd ${FLUPS_DIR}/samples/validation
ARCH_FILE=make_arch/make.meluxina make all -j 
cd -
