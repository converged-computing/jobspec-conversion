#!/bin/bash
#FLUX: --job-name=pipeinfer
#FLUX: -c=112
#FLUX: --exclusive
#FLUX: --queue=eval
#FLUX: -t=36000
#FLUX: --urgency=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/'

echo "#################### Job submission script. #############################"
cat $0
echo "################# End of job submission script. #########################"
module --force purge; module load modules/2.1.1-20230405
module load slurm gcc cmake nccl cuda/11.8.0 cudnn/8.4.0.27-11.6 openmpi/4.0.7
nvidia-smi
source ~/miniconda3/bin/activate tf2
which python3
python3 --version
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/mnt/sw/nix/store/3xpm36w2kcri3j1m5j15hg025my1p4kx-cuda-11.8.0/extras/CUPTI/lib64/
train_dir="/mnt/ceph/users/ewulff/particleflow/experiments/bsm10_1GPU_clic-gnn-tuned-v130_20230724_035617_375578.workergpu037"
declare -a bs=(1024 512 256 128 64 32 16 8 4 2 1)
for i in "${bs[@]}"
do
    echo 'Starting inference.'
    python3 mlpf/pipeline.py infer \
        --train-dir $train_dir \
        --nevents 4000 \
        --bs "$i" \
        --num-runs 11 \
        -o /mnt/ceph/users/ewulff/particleflow/inference_tests/results_$SLURMD_NODENAME.json
    echo 'Inference done.'
done
