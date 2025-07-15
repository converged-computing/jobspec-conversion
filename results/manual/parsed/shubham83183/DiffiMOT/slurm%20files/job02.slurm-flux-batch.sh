#!/bin/bash
#FLUX: --job-name=Diffitrack_private04
#FLUX: -c=16
#FLUX: --queue=gpu
#FLUX: -t=86399
#FLUX: --urgency=16

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
python -m  torch.distributed.launch --nproc_per_node=4 --nnodes=4 --node_rank=3 --master_addr=10.2.14.191 --master_port=8999 --use_env\
            src/train.py with \
            mot17_crowdhuman \
            deformable \
            multi_frame \
            tracking \
            output_dir=models/mot17_crowdhuman_deformable_multi_frame_WithoutInf_lambda1000_6000Abs_80_120 \
