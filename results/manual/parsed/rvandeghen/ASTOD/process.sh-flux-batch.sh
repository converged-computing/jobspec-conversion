#!/bin/bash
#FLUX: --job-name=strawberry-parsnip-5768
#FLUX: --queue=cpu
#FLUX: --urgency=16

echo "Start processing"
conda activate astod
python src/create_pseudo.py \
    --train-file coco/annotations/instances_train2017.$1@$2.json  \
    --unlabeled-file coco/annotations/instances_train2017.$1@$2-unlabeled.json \
    --pseudo-file coco/annotations/pseudo_labels/faster_rcnn/$2/teacher/model_$1/results_annotations.json \
    --output-file coco/annotations/pseudo_labels/faster_rcnn/$2/teacher/model_$1/pseudo_annotations_$3_glob.json \
    --bins $3 \
    --glob
