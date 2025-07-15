#!/bin/bash
#FLUX: --job-name=gassy-kitty-4434
#FLUX: -t=362439
#FLUX: --urgency=16

export LD_LIBRARY_PATH='/gpfs/home/mli/.conda/envs/banmo-cu113/lib/:$LD_LIBRARY_PATH'

module load Miniconda3
cd ./banmo
eval "$(conda shell.bash hook)"
source /soft/easybuild/x86_64/software/Miniconda3/4.9.2/etc/profile.d/conda.sh
conda activate banmo-cu113
export LD_LIBRARY_PATH=/gpfs/home/mli/.conda/envs/banmo-cu113/lib/:$LD_LIBRARY_PATH
seqname="cat-pikachiu"
python preprocess/img2lines.py --seqname $seqname
bash scripts/template.sh 0,1 $seqname 10001 "no" "no"
bash scripts/render_mgpu.sh 0,1 $seqname logdir/$seqname-e120-b256-ft2/params_latest.pth \
        "0 1 2 3 4 5 6 7 8 9 10" 256
