#!/bin/bash
#FLUX: --job-name=loopy-nunchucks-6391
#FLUX: --queue=debug
#FLUX: -t=720
#FLUX: --urgency=16

source /gpfsnyu/home/jz2915/config.sh
module purge
module load anaconda3/5.2.0
python $runperf $expsnum $data $perf $re
