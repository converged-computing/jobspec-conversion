#!/bin/bash
#FLUX: --job-name=ctf_frostt
#FLUX: -N=64
#FLUX: -n=4096
#FLUX: --queue=normal
#FLUX: -t=7200
#FLUX: --urgency=16

export CTF_PPN='64'
export OMP_NUM_THREADS='1'
export LD_LIBRARY_PATH='/opt/apps/intel18/python2/2.7.15/lib:/opt/apps/libfabric/1.7.0/lib:/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/lib:/opt/intel/debugger_2018/libipt/intel64/lib:/opt/intel/debugger_2018/iga/lib:/opt/intel/compilers_and_libraries_2018.2.199/linux/daal/../tbb/lib/intel64_lin/gcc4.4:/opt/intel/compilers_and_libraries_2018.2.199/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.2.199/linux/tbb/lib/intel64/gcc4.7:/opt/intel/compilers_and_libraries_2018.2.199/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.2.199/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.2.199/linux/ipp/lib/intel64:/opt/intel/compilers_and_libraries_2018.2.199/linux/compiler/lib/intel64:/opt/apps/gcc/6.3.0/lib64:/opt/apps/gcc/6.3.0/lib:/opt/apps/xsede/gsi-openssh-7.5p1b/lib64:/opt/apps/xsede/gsi-openssh-7.5p1b/lib:::/home1/06131/tg854305/ctf1/lib_shared:/home1/06131/tg854305/ctf1/lib_python:/opt/intel/compilers_and_libraries_2017.4.196/linux/mkl/lib/intel64'
export PYTHONPATH='/opt/apps/intel18/impi18_0/python2/2.7.15/lib/python2.7/site-packages:/home1/06131/tg854305/ctf1/lib_python'

module list
pwd
date
export CTF_PPN=64
export OMP_NUM_THREADS=1
export LD_LIBRARY_PATH="/opt/apps/intel18/python2/2.7.15/lib:/opt/apps/libfabric/1.7.0/lib:/opt/intel/compilers_and_libraries_2018.2.199/linux/mpi/intel64/lib:/opt/intel/debugger_2018/libipt/intel64/lib:/opt/intel/debugger_2018/iga/lib:/opt/intel/compilers_and_libraries_2018.2.199/linux/daal/../tbb/lib/intel64_lin/gcc4.4:/opt/intel/compilers_and_libraries_2018.2.199/linux/daal/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.2.199/linux/tbb/lib/intel64/gcc4.7:/opt/intel/compilers_and_libraries_2018.2.199/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.2.199/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2018.2.199/linux/ipp/lib/intel64:/opt/intel/compilers_and_libraries_2018.2.199/linux/compiler/lib/intel64:/opt/apps/gcc/6.3.0/lib64:/opt/apps/gcc/6.3.0/lib:/opt/apps/xsede/gsi-openssh-7.5p1b/lib64:/opt/apps/xsede/gsi-openssh-7.5p1b/lib:::/home1/06131/tg854305/ctf1/lib_shared:/home1/06131/tg854305/ctf1/lib_python:/opt/intel/compilers_and_libraries_2017.4.196/linux/mkl/lib/intel64"
export PYTHONPATH="/opt/apps/intel18/impi18_0/python2/2.7.15/lib/python2.7/site-packages:/home1/06131/tg854305/ctf1/lib_python"
ibrun python test.py xaa 4821207 1774269 1805187
