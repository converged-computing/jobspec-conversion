#!/bin/bash
#FLUX: --job-name=faux-cattywampus-0767
#FLUX: --urgency=16

cd ${SLURM_SUBMIT_DIR}
. ../conf/profile_mesonh-LXifort-R8I4-MNH-V5-7-0-MPIAUTO-O2
time gmake -j 10
time gmake -j 1 installmaster
