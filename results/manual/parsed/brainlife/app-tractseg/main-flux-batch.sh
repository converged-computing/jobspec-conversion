#!/bin/bash
#FLUX: --job-name=chunky-gato-1358
#FLUX: --priority=16

module load cuda/10.0
set -x
set -e
echo "running tractseg and tractometry on peak length"
rm -rf tractseg_output && mkdir -p tractseg_output
time singularity exec --nv -e docker://brainlife/tractseg:2.7 ./run.sh
echo "creating wmc"
mkdir -p wmc/tracts
singularity exec -e docker://brainlife/dipy:1.1.1 ./create_wmc.py
mkdir -p wmc/surfaces
singularity exec -e docker://brainlife/pythonvtk:1.1 ./mask2surface.py
echo "merging .tck into 1"
mkdir -p tck
singularity exec -e docker://brainlife/mrtrix3:3.0.0 tckedit -force tractseg_output/TOM_trackings/*.tck tck/track.tck
actualsize=$(wc -c <"tck/track.tck")
if [ $actualsize -le 10000 ]; then
    echo "tck/track.tck seems empty. exiting"
    exit 1
fi
mkdir -p output
ln -sf ../tractseg_output/bundle_segmentations output/masks
mkdir -p endingmasks
ln -sf ../tractseg_output/endings_segmentations endingmasks/masks
mkdir -p tractseg_tractometry
ln -sf ../tractseg_output/Tractometry_peaks.csv tractseg_tractometry/tractmeasures.csv
echo "all done"
