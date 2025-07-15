#!/bin/bash
#FLUX: --job-name=strawberry-poo-1473
#FLUX: -c=18
#FLUX: --queue=gpu
#FLUX: --urgency=16

module load 2021
module load TensorFlow/2.6.0-foss-2021a-CUDA-11.3.1
cp -r "$HOME/ismi-camelyon" "$TMPDIR"
cd "$TMPDIR/ismi-camelyon"
pip install -r requirements.txt
python train.py "geertnet" --da 3
python test.py "submission.csv" "geertnet" \
    "$HOME/patch_camelyon/camelyonpatch_level_2_split_test_x.h5" \
    "$HOME/patch_camelyon/camelyonpatch_level_2_split_test_y.h5"
RESULTS_FOLDER="$HOME/ismi-camelyon/results/2-geertnet+da3/$(date '+%Y%m%dT%H%M%S')"
mkdir -p $RESULTS_FOLDER
cp *.csv $RESULTS_FOLDER
cp *.json $RESULTS_FOLDER
cp *.hdf5 $RESULTS_FOLDER
cp -r logs $RESULTS_FOLDER
