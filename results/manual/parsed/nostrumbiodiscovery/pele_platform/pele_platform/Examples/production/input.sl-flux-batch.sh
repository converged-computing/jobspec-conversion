#!/bin/bash
#FLUX: --job-name=PELE_MPI
#FLUX: -n=10
#FLUX: --urgency=16

export I_MPI_PMI_LIBRARY='/usr/lib64/libpmi.so'
export PYTHONPATH='/work/NBD_Utilities/PELE/PELE_Softwares/pele_platform/:/home/ssaenoon/AdaptivePELE/:$PYTHONPATH'

module purge
unset PYTHONPATH
unset LD_LIBRARY_PATH
module load impi/2018.1.163-iccifort-2018.1.163-GCC-6.4.0-2.28 Boost/1.66.0-intel-2018a wjelement/1.3-intel-2018a
module load intel Python/2.7.14-intel-2018a
export I_MPI_PMI_LIBRARY=/usr/lib64/libpmi.so
export PYTHONPATH=/sNow/easybuild/centos/7.4.1708/Skylake/software/PyMOL/2.2.0_0/lib/python2.7/site-packages/:$PYTHONPATH
export PYTHONPATH=/work/NBD_Utilities/PELE/PELE_Softwares/pele_platform/:/home/ssaenoon/AdaptivePELE/:$PYTHONPATH
python -m pele_platform.main input.yaml
