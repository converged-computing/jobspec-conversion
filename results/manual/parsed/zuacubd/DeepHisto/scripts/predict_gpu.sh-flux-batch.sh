#!/bin/bash
#FLUX: --job-name=vgg19_Predict
#FLUX: -c=4
#FLUX: --queue=GPUNodes
#FLUX: --urgency=16

echo "starting .."
srun singularity exec /logiciels/containerCollections/CUDA9/keras-tf.sif python3 "mc_programs/main.py" -predict True -network vgg19
echo "done"
