#!/bin/bash
#FLUX: --job-name=faux-caramel-7546
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: --priority=16

module load 2021
module load TensorFlow/2.6.0-foss-2021a-CUDA-11.3.1
cp -r "$HOME/ismi-camelyon" "$TMPDIR"
cd "$TMPDIR/ismi-camelyon"
pip install -r requirements.txt
python train.py "resnet" --da 2
python test.py "submission.csv" "resnet" \
    "$HOME/patch_camelyon/camelyonpatch_level_2_split_test_x.h5" \
    "$HOME/patch_camelyon/camelyonpatch_level_2_split_test_y.h5" --tta
RESULTS_FOLDER="$HOME/ismi-camelyon/results/4-resnet-da-tta/$(date '+%Y%m%dT%H%M%S')"
mkdir -p $RESULTS_FOLDER
cp *.csv $RESULTS_FOLDER
cp *.json $RESULTS_FOLDER
cp *.hdf5 $RESULTS_FOLDER
cp -r logs $RESULTS_FOLDER
