#!/bin/bash
#FLUX: --job-name=tst_att
#FLUX: -c=10
#FLUX: --queue=LKEBgpu
#FLUX: -t=0
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/share/software/NVIDIA/cudnn-9.0/lib64/'

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/share/software/NVIDIA/cuda-9.0/extras/CUPTI/lib64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/share/software/NVIDIA/cuda-9.0/lib64/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/share/software/NVIDIA/cudnn-9.0/lib64/
source /exports/lkeb-hpc/syousefi/Programs/TF112/bin/activate
echo "on Hostname = $(hostname)"
echo "on GPU      = $CUDA_VISIBLE_DEVICES"
echo
echo "@ $(date)"
echo
python /exports/lkeb-hpc/syousefi/2-lkeb-17-dl01/syousefi/TestCode/EsophagusProject/Code/dense_net_3d_segmentation-1-dice-tumor--106/functions/plot/PR_curve.py --where_to_run Cluster
