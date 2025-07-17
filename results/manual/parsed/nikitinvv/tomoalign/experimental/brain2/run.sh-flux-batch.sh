#!/bin/bash
#FLUX: --job-name=milky-lizard-7942
#FLUX: -n=64
#FLUX: --queue=v100
#FLUX: -t=144000
#FLUX: --urgency=16

nvidia-smi
module add GCC/8.3.0 iccifort/2019.5.281 CUDA/10.1.243
cd /mxn/visitors/vviknik/tomoalign_vincent/tomoalign/brain2
python cg.py 4 720 /data/staff/tomograms/vviknik/tomoalign_vincent_data/brain/Brain_Petrapoxy_day2_2880prj_1440deg_167;
