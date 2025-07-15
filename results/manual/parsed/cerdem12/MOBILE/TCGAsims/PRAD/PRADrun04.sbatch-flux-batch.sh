#!/bin/bash
#FLUX: --job-name=angry-chip-6874
#FLUX: --priority=16

module add MATLAB/2023a.Update4
module add GCCcore/11.3.0
module add X11/20220504
module add binutils/2.38
matlab -nojvm -nodisplay -r "PRADSPINK1"
