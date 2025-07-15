#!/bin/bash
#FLUX: --job-name=eccentric-punk-1356
#FLUX: --urgency=16

module load matlab/R2019a
echo 'started at:'
date
echo; echo; echo; echo;
matlab-threaded –nodisplay -nodesktop -r "launch_parpool(12); senseDyn"
echo; echo; echo; echo;
echo 'finished at:'
date
