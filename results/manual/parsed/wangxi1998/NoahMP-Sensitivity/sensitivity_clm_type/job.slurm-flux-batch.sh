#!/bin/bash
#FLUX: --job-name=clm1
#FLUX: -n=56
#FLUX: -t=43200
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/discover/nobackup/projects/lis/libs/netcdf/4.3.3.1_intel-14.0.3.174_sp3/lib'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/discover/nobackup/projects/lis/libs/netcdf/4.3.3.1_intel-14.0.3.174_sp3/lib
envVar="{'LD_LIBRARY_PATH': '$LD_LIBRARY_PATH'}"
cd /discover/nobackup/gnearing/projects/NoahMP-Sensitivity/sensitivity_clm_type
/usr/local/other/PoDS/PoDS/pods.py -e " $envVar " -x /discover/nobackup/gnearing/projects/NoahMP-Sensitivity/sensitivity_clm_type/execfile.pods -n 16
exit 0
