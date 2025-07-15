#!/bin/bash
#FLUX: --job-name=PRE-VOCAB
#FLUX: --queue=eap
#FLUX: -t=3600
#FLUX: --urgency=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
echo "" > preprocess_vocab.out
module --quiet purge
module --quiet --force purge
module load LUMI/22.06
module load cray-python/3.9.4.2
module load rocm/5.1.4
source /project/project_465000157/pytorch_1.12.1/bin/activate
SOURCE_FILE=$1
VOCAB_FILE=$2
TOKENIZER=$3
python3 create_vocab.py --input_path "${SOURCE_FILE}" --vocab_path "${VOCAB_FILE}" --tokenizer_type "${TOKENIZER}" --no-lowercase || exit 1
exit 0
