#!/bin/bash
#FLUX: --job-name="JOBNAME_quark_init"
#FLUX: -t=86400
#FLUX: --priority=16

<GPU1_CONFIG>
<ENV_LOAD>
set -e -x -o pipefail
SCRIPTPATH=<SCRIPTPATH>
WORKDIR=<WORKDIR>
Timestamp=<Timestamp>
decoder_ckpt=<SDA>
GEN_BATCH_SIZE_INIT=32
INIT_SEQUENCES=$WORKDIR/quark_init_${Timestamp}.json
python $SCRIPTPATH/predict_decoder.py \
        --checkpoint $decoder_ckpt \
        --output_prefix ${INIT_SEQUENCES%.*} \
        --gen_do_sample \
        --gen_max_new_tokens 1398 \
        --gen_num_return_sequences $GEN_BATCH_SIZE_INIT \
        --num_batches 512
