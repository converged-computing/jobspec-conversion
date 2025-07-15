#!/bin/bash
#FLUX: --job-name=compile_MNH
#FLUX: --priority=16

set -x
pwd
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O2
time gmake -j 16
time gmake -j 1 installmaster
