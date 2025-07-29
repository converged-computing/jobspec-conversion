#!/bin/bash
#FLUX: --job-name=cxid9114_avg
#FLUX: --queue=regular
#FLUX: -t=3600
#FLUX: --urgency=16

if [ ! -f ./avg.sh ]; then
    echo "#\!/bin/bash" >> ./avg.sh
    echo "export SIT_DATA=/reg/g/psdm/data"  >> ./avg.sh
    echo "export SIT_PSDM_DATA=/reg/d/psdm"  >> ./avg.sh
    echo "source /build/setpaths.sh"  >> ./avg.sh
    echo "cxi.mpi_average -x cxid9114 -r \${1} -a CxiDs2.0:Cspad.0 -d 572 -v -g 6.85" >> ./avg.sh
fi
srun -n 68 -c 1 --cpu_bind=cores shifter ./avg.sh ${1} -R
srun -n 68 -c 1 --cpu_bind=cores shifter ./avg.sh ${2}
