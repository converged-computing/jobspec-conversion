#!/bin/bash
#FLUX: --job-name=joyous-ricecake-7977
#FLUX: --priority=16

cd ${SLURM_SUBMIT_DIR}
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIAUTO-O2
time gmake -j 10
time gmake -j 1 installmaster
