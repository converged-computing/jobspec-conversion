#!/bin/bash
#FLUX: --job-name=iit_test
#FLUX: -t=86400
#FLUX: --urgency=16

LD_PRELOAD=/usr/lib64/libstdc++.so.6
module load nixpkgs
module load matlab/2018b
chmod 775 /project/6001934/jf2lin/gitlab/kalmanfilter/General_FKEKF/DynamicsModelMatlab/MatlabWrapper/DynamicsModelMatlab.mexa64
ldd -d /project/6001934/jf2lin/gitlab/kalmanfilter/General_FKEKF/DynamicsModelMatlab/MatlabWrapper/DynamicsModelMatlab.mexa64
srun matlab -nodisplay -nojvm -singleCompThread -r "IOCMain" -sd "/project/6001934/jf2lin/gitlab/expressive-ioc/InverseOC"
