#!/bin/bash
#FLUX: --job-name=anxious-punk-2662
#FLUX: --urgency=16

export HF_DATASETS_CACHE='/cephyr/NOBACKUP/groups/smnlp/.hg_cache'
export TRANSFORMERS_CACHE='/cephyr/NOBACKUP/groups/smnlp/.hg_cache'

module load GCC/10.2.0  CUDA/11.1.1-GCC-10.2.0  OpenMPI/4.0.5-gcccuda-2020b
module load PyTorch/1.9.0-fosscuda-2020b
module load Python/3.8.6-GCCcore-10.2.0
export HF_DATASETS_CACHE="/cephyr/NOBACKUP/groups/smnlp/.hg_cache"
export TRANSFORMERS_CACHE="/cephyr/NOBACKUP/groups/smnlp/.hg_cache"
source /cephyr/users/robertos/Alvis/venv/transformers/bin/activate
DATA=/cephyr/users/robertos/Alvis/few-shot-gec/data
MODEL=/cephyr/NOBACKUP/groups/smnlp/GPT-SW3
for SYSTEM in granska mt-base s2; do
    echo "Launching at:"
    date
    python -u /cephyr/users/robertos/Alvis/.local/scribendi_score/scribendi.py \
	--src $DATA/nyberg_test_dev/Nyberg.CEFR_A.test.orig.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_B.test.orig.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_C.test.orig.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_ABC.test.orig.txt \
	--pred $DATA/experiments/Nyberg.CEFR_A.test.$SYSTEM:$DATA/experiments/Nyberg.CEFR_B.test.$SYSTEM:$DATA/experiments/Nyberg.CEFR_C.test.$SYSTEM:$DATA/experiments/Nyberg.CEFR_ABC.test.$SYSTEM \
	--model_id "$MODEL"
    echo "Finished at:"
    date
done
echo "Launching at:"
date
python -u /cephyr/users/robertos/Alvis/.local/scribendi_score/scribendi.py \
    --src $DATA/nyberg_test_dev/Nyberg.CEFR_A.test.orig.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_B.test.orig.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_C.test.orig.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_ABC.test.orig.txt \
    --pred $DATA/nyberg_test_dev/Nyberg.CEFR_A.test.corr.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_B.test.corr.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_C.test.corr.txt:$DATA/nyberg_test_dev/Nyberg.CEFR_ABC.test.corr.txt \
    --model_id "$MODEL"
echo "Finished at:"
date
