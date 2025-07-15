#!/bin/bash
#FLUX: --job-name=RSA_GPR_robust
#FLUX: -n=64
#FLUX: --queue=idle
#FLUX: -t=5100
#FLUX: --urgency=16

vpkg_require matlab/default
. /opt/shared/slurm/templates/libexec/openmp.sh
UD_EXEC matlab -nodisplay -batch RSA_GPR_robust_v3
matlab_rc=$?
if [ $matlab_rc -ne 0 ]; then exit $matlab_rc; fi
