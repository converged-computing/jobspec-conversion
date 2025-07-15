#!/bin/bash
#FLUX: --job-name=buttery-hope-1014
#FLUX: --urgency=16

module add MATLAB/2023a.Update4
module add GCCcore/11.3.0
module add X11/20220504
module add binutils/2.38
matlab -nojvm -nodisplay -r "PRADERG"
