#!/bin/bash
#FLUX: --job-name=evasive-rabbit-9988
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

module purge
module load comp/gcc/7.2.0
module load nvidia/cuda/10.0
echo $PWD
echo "Entering working directory"
cd ~/svbrdf-estimation/development/multiImage_pytorch/
echo $PWD
source activate svbrdf-env
echo "Running training"
python -u main.py --mode train --input-dir "./../../../materialsData_multi_image/train/" --image-count 0 --model-dir "./models" --epochs 200 --save-frequency 1
exitCode=$?
echo "Finished training (exit code $exitCode)"
conda deactivate
exit $exitCode
