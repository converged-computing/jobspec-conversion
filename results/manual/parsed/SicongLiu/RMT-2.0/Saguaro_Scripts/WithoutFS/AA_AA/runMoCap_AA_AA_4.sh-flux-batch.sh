#!/bin/bash
#FLUX: --job-name=confused-destiny-5157
#FLUX: --priority=16

module load gcc/4.9.2
module load matlab/2015b
cd /home/sliu104/MoCapGaussian/
matlab -nodisplay -nosplash -nodesktop -r "runMoCap_AA_AA_4()"
