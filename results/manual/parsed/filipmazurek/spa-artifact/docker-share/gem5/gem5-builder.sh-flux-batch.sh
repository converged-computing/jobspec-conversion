#!/bin/bash
#FLUX: --job-name=butterscotch-staircase-6984
#FLUX: -c=9
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/hpc/group/brownlab/fjm7/miniconda3/envs/gem5_env/lib'

. "/hpc/group/brownlab/fjm7/miniconda3/etc/profile.d/conda.sh"
conda activate gem5_env
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/hpc/group/brownlab/fjm7/miniconda3/envs/gem5_env/lib
python `which scons` build/X86/gem5.fast PROTOCOL=MESI_Two_Level -j 9
