#!/bin/bash
#FLUX: --job-name=eval2
#FLUX: -c=8
#FLUX: --queue=gpu
#FLUX: -t=14459
#FLUX: --priority=16

module load GpuModules
module load cuda10.2/toolkit/10.2.89
module unload tensorflow2-py37-cuda11.2-gcc8/2.5.2
module unload protobuf3-gcc8/3.8.0nccl2-cuda11.2-gcc8/2.11.4
module unload cudnn8.1-cuda11.2/8.1.1.33  
module unload protobuf3-gcc8/3.8.0
module unload cuda11.2/toolkit/11.2.2
module unload openblas/dynamic/0.3.7
module unload hdf5_18/1.8.21
source ~/.bashrc
conda deactivate
cd  /work/ws-tmp/g051507-thesis/g051507-thesis-1679703002/Diff_matching/trackformer
conda activate  Diff_matching
python src/track.py with reid
