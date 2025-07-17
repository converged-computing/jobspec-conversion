#!/bin/bash
#FLUX: --job-name=1203PRADSPINK1
#FLUX: -n=16
#FLUX: -t=43200
#FLUX: --urgency=16

module add MATLAB/2023a.Update4
module add GCCcore/11.3.0
module add X11/20220504
module add binutils/2.38
matlab -nojvm -nodisplay -r "PRADSPINK1"
