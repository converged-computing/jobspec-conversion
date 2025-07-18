#!/bin/bash
#FLUX: --job-name=scruptious-buttface-5986
#FLUX: -t=360
#FLUX: --urgency=16

JSONS=($(cat experiments.txt))
if [[ -n "${SLURM_ARRAY_TASK_ID}" ]]; then
  JSONS=(${JSONS[${SLURM_ARRAY_TASK_ID}]})
fi
for JSON in ${JSONS[@]}; do
    SETTING="$(basename $(dirname ${JSON}))"
    EXPERIMENT="$(basename ${JSON} .json)"
    mkdir -p "models/${SETTING}"
    MODEL="models/${SETTING}/${EXPERIMENT}"
    python run.py train "${JSON}" --include-package cyber.dataset_readers --include-package cyber.models -s "${MODEL}" \
        || grep Error "${MODEL}/stderr.log" >> ${SETTING}_accuracy.tsv
    grep -h test_accuracy ${MODEL}/stdout.log | sed 's/.*://;s/,//;s/ //g' >> ${SETTING}_accuracy.tsv
done
