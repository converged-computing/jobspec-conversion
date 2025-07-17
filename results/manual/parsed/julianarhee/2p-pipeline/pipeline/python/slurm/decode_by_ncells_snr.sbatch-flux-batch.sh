#!/bin/bash
#FLUX: --job-name=decode
#FLUX: -n=8
#FLUX: --queue=cox
#FLUX: -t=120
#FLUX: --urgency=16

module load centos6/0.0.1-fasrc01
module load matlab/R2015b-fasrc01
module load Anaconda/5.0.1-fasrc01
source activate /n/coxfs01/2p-pipeline/envs/pipeline
EXP="$1"
TRACEID="$2"
RTEST="$3"
OVERLAP="$4"
ANALYSIS="$5"
CVAL="$6"
VAREA="$7"
SAMPLESIZE="$8"
DKEY="$9"
EPOCH="${10}"
echo "ANALYSIS: ${ANALYSIS}"
echo "overlap: ${OVERLAP}"
echo "varea: ${VAREA}"
echo "ncells: ${SAMPLE_SIZE}"
echo "dkey: ${DKEY}"
echo "EPOCH: ${EPOCH}"
python /n/coxfs01/2p-pipeline/repos/2p-pipeline/pipeline/python/classifications/decode_by_ncells.py -E $EXP -t $TRACEID -R $RTEST -n 8 -N 100 --new -o $OVERLAP -C ${CVAL} -V $VAREA -S $SAMPLESIZE -X $ANALYSIS -k $DKEY --epoch $EPOCH --shuffle --snr
