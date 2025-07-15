#!/bin/bash
#FLUX: --job-name=ewc_eval
#FLUX: --queue=spgpu
#FLUX: -t=21600
#FLUX: --priority=16

cd GroundingDINO
python setup.py develop
cd ..
WEIGHTS="/scratch/eecs545w24_class_root/eecs545w24_class/shared_data/dinosaur/model_weights/gdinot-1.8m-odvg.pth"
python eval.py --real --spatial --weights=$WEIGHTS # refcoco spatial
python eval.py --real --weights=$WEIGHTS # refcoco nonspatial
python eval.py --weights=$WEIGHTS # synthetic validation
LOCATION="/scratch/eecs545w24_class_root/eecs545w24_class/shared_data/dinosaur/model_checkpoints/ewc_mixed_checkpoints"
for i in 0 1 2 3 4 5 6;
do
    WEIGHTS="$LOCATION/checkpoint000$i.pth"
    python eval.py --real --spatial --weights=$WEIGHTS # refcoco spatial
    python eval.py --real --weights=$WEIGHTS # refcoco nonspatial
    python eval.py --weights=$WEIGHTS # synthetic validation
done
