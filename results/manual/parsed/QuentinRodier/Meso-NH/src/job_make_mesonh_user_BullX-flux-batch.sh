#!/bin/bash
#FLUX: --job-name=compile
#FLUX: -t=7500
#FLUX: --urgency=16

export VER_USER='                ########## Your own USER Directory'

export VER_USER=                ########## Your own USER Directory
set -x
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-${VER_USER}-MPIINTEL-O3
time gmake user
time gmake -j 1 installuser
