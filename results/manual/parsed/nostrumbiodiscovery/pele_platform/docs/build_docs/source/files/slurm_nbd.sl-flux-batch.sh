#!/bin/bash
#FLUX: --job-name=frigid-fudge-0630
#FLUX: -n=60
#FLUX: --urgency=16

export SCHRODINGER='/sNow/easybuild/centos/7.4.1708/Skylake/software/schrodinger2017-4/'
export PELE='/shared/work/NBD_Utilities/PELE/PELE_Softwares/bin/PELE1.6/'
export LC_ALL='C; unset LANGUAGE'
export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export PYTHONPATH='/shared/work/NBD_Utilities/PELE/PELE_Softwares/PelePlatform/depend:$PYTHONPATH'
export PATH='/shared/work/NBD_Utilities/PELE/PELE_Softwares/PelePlatform/depend/bin:$PATH'
export LD_LIBRARY_PATH='/shared/work/NBD_Utilities/PELE/PELE_Softwares/local_deps/pele_deps/boost_1_52/lib:$LD_LIBRARY_PATH'

module purge
export SCHRODINGER="/sNow/easybuild/centos/7.4.1708/Skylake/software/schrodinger2017-4/"
export PELE="/shared/work/NBD_Utilities/PELE/PELE_Softwares/bin/PELE1.6/"
export LC_ALL=C; unset LANGUAGE
unset PYTHONPATH
module load impi/2018.1.163-iccifort-2018.1.163-GCC-6.4.0-2.28 wjelement/1.3-intel-2018a
module load Crypto++/6.1.0-intel-2018a OpenBLAS/0.2.20-GCC-6.4.0-2.28
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export PYTHONPATH="/shared/work/NBD_Utilities/PELE/PELE_Softwares/PelePlatform/depend:$PYTHONPATH"
export PATH="/shared/work/NBD_Utilities/PELE/PELE_Softwares/PelePlatform/depend/bin:$PATH"
export LD_LIBRARY_PATH=/shared/work/NBD_Utilities/PELE/PELE_Softwares/local_deps/pele_deps/boost_1_52/lib:$LD_LIBRARY_PATH
python -m pele_platform.main input.yaml
