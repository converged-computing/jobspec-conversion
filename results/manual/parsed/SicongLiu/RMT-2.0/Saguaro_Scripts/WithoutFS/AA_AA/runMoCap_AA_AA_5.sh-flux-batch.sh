#!/bin/bash
#FLUX: --job-name=peachy-latke-5798
#FLUX: -n=4
#FLUX: --queue=serial
#FLUX: -t=720
#FLUX: --urgency=16

module load gcc/4.9.2
module load matlab/2015b
cd /home/sliu104/MoCapGaussian/
matlab -nodisplay -nosplash -nodesktop -r "runMoCap_AA_AA_5()"
