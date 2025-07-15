#!/bin/bash
#FLUX: --job-name=re
#FLUX: -c=128
#FLUX: --gpus-per-task=8
#FLUX: --exclusive
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --priority=16

pwd; hostname; date
echo "start RE..."
tag=n2c2_9b
CONF=/red/gatortron-phi/workspace/2021gatortron/nemo_downstream/re/slurm/n2c2_9b.yaml
CONTAINER=/red/gatortron-phi/workspace/containers/nemo120.sif
output=/red/gatortron-phi/workspace/2021gatortron/nemo_downstream/re/results/${tag}
singularity exec --nv $CONTAINER \
    python /red/gatortron-phi/workspace/2021gatortron/nemo_downstream/re/re_ddp.py \
        --gpus $SLURM_GPUS_PER_TASK \
        --pred_output $output \
        --re_config $CONF
sleep 10
gs_set=/red/gatortron-phi/workspace/2021gatortron/data/re/2018n2c2/gold_standard_set.pkl
test_supp=/red/gatortron-phi/workspace/2021gatortron/data/re/2018n2c2/2018n2c2_marker_format_1/testsupp.tsv
singularity exec $CONTAINER python /red/gatortron-phi/workspace/2021gatortron/nemo_downstream/re/brat_eval_res.py \
    --gs $gs_set \
    --pred ${output}/predict_labels.txt \
    --supp $test_supp \
    --output ${output}/res_prf.txt
