#!/bin/bash
#FLUX: --job-name=Fig8_mdlStruct
#FLUX: -n=64
#FLUX: --queue=idle
#FLUX: -t=12300
#FLUX: --urgency=16

vpkg_require matlab/default
. /opt/shared/slurm/templates/libexec/openmp.sh
UD_EXEC matlab -nodisplay -batch Fig5_GPR_cluster
matlab_rc=$0
if [ $matlab_rc -ne 0 ]; then exit $matlab_rc; fi
