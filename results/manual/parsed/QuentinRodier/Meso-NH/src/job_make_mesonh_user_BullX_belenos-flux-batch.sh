#!/bin/bash
#FLUX: --job-name=compile
#FLUX: -c=2
#FLUX: -t=3600
#FLUX: --priority=16

export VER_USER='                     ######## Your own USER Directory'

export VER_USER=                     ######## Your own USER Directory
set -x
pwd
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-${VER_USER}-MPIAUTO-O2
time make user -j 2
time make -j 1 installuser
