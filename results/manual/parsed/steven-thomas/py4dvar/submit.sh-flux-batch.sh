#!/bin/bash
#FLUX: --job-name=fourdvar_main
#FLUX: --queue=physical
#FLUX: -t=3600
#FLUX: --urgency=16

export LD_LIBRARY_PATH='${LD_LIBRARY_PATH}:/usr/local/easybuild/software/netCDF/4.5.0-spartan_intel-2017.u2/lib64'

module purge
module load netCDF
module load netCDF-Fortran
module load OpenMPI/3.1.0-iccifort-2018.u4-GCC-8.2.0-cuda9-ucx
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/easybuild/software/netCDF/4.5.0-spartan_intel-2017.u2/lib64"
cd /home/stevenpt/fourdvar/py4dvar
python runscript.py >& output.txt
