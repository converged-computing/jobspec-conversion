#!/bin/bash
#FLUX: --job-name=compile
#FLUX: -t=14700
#FLUX: --urgency=16

set -x
pwd
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIINTEL-O3
time gmake -j 4
time gmake -j 1 installmaster
