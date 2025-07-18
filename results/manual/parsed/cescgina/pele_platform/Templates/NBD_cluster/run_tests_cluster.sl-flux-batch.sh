#!/bin/bash
#FLUX: --job-name=PELE_MPI_test
#FLUX: -n=5
#FLUX: --urgency=16

export SCHRODINGER='/sNow/easybuild/centos/7.4.1708/Skylake/software/schrodinger2017-4/'
export SCHRODINGER_PYTHONPATH='/sNow/easybuild/centos/7.4.1708/Skylake/software/schrodinger2017-4/internal/lib/python2.7/site-packages'
export PELE='/shared/work/NBD_Utilities/PELE/PELE_Softwares/bin/PELE1.6/'
export LC_ALL='C; unset LANGUAGE'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export LD_LIBRARY_PATH='/shared/work/NBD_Utilities/PELE/PELE_Softwares/local_deps/pele_deps/boost_1_52/lib:$LD_LIBRARY_PATH'
export PYTHONPATH='/home/agruzka/work_pele_platform:$PYTHONPATH'
export SRUN='1  # this is to avoid having to set usesrun: true in input.yaml'

module purge
export SCHRODINGER="/sNow/easybuild/centos/7.4.1708/Skylake/software/schrodinger2017-4/"
export SCHRODINGER_PYTHONPATH="/sNow/easybuild/centos/7.4.1708/Skylake/software/schrodinger2017-4/internal/lib/python2.7/site-packages"
export PELE="/shared/work/NBD_Utilities/PELE/PELE_Softwares/bin/PELE1.6/"
export LC_ALL=C; unset LANGUAGE
unset PYTHONPATH
module load impi/2018.1.163-iccifort-2018.1.163-GCC-6.4.0-2.28 wjelement/1.3-intel-2018a
module load Crypto++/6.1.0-intel-2018a OpenBLAS/0.2.20-GCC-6.4.0-2.28
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export LD_LIBRARY_PATH=/shared/work/NBD_Utilities/PELE/PELE_Softwares/local_deps/pele_deps/boost_1_52/lib:$LD_LIBRARY_PATH
export PYTHONPATH="/shared/work/NBD_Utilities/PELE/PELE_Softwares/PelePlatform/depend:$PYTHONPATH"
export SRUN=1  # this is to avoid having to set usesrun: true in input.yaml
export PYTHONPATH="/home/agruzka/work_pele_platform:$PYTHONPATH"
