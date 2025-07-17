#!/bin/bash
#FLUX: --job-name=frigid-earthworm-8985
#FLUX: -N=5
#FLUX: --queue=a100
#FLUX: -t=7200
#FLUX: --urgency=16

export PYTHONNOUSERSITE='true'
export MV2_HOME='/home/gulhane.2/mvapich2-installation/nvidia/gdr2.3.7_cuda11.6_gcc10.3.0'
export CUDA_HOME='/home/gulhane.2/cuda/setup.sh'
export LD_LIBRARY_PATH='$MV2_HOME/lib:$LD_LIBRARY_PATH'
export CPATH='$MV2_HOME/include:$CPATH'
export PATH='$MV2_HOME/bin:$PATH'

mini_env=PyTorch_1.13_n
source $HOME/miniconda3/bin/activate
conda activate ${mini_env}
module load cuda/11.6
module load gcc/10.3.0
module load cmake/3.22.2
export PYTHONNOUSERSITE=true
export MV2_HOME=/home/gulhane.2/mvapich2-installation/nvidia/gdr2.3.7_cuda11.6_gcc10.3.0
export CUDA_HOME=/home/gulhane.2/cuda/setup.sh
export LD_LIBRARY_PATH=$CUDA_HOME/lib:$LD_LIBRARY_PATH
export CPATH=$CUDA_HOME/include:$CPATH
export PATH=$MV2_HOME/bin:$PATH
export LD_LIBRARY_PATH=$MV2_HOME/lib:$LD_LIBRARY_PATH
export CPATH=$MV2_HOME/include:$CPATH
total_np=5
PPN=1
hostfile=logs/hosts_$SLURM_JOBID
rm $hostfile &> /dev/null # for consecutive calls to this script in interactive jobs 
ncount=0
for i in `scontrol show hostnames $SLURM_NODELIST`
do
    if [ $ncount gt $total_np ]
    then
        break
    fi
    for j in `seq 1 $PPN`
    do
        if [ $ncount gt $total_np ]
        then
            break
        fi
        ncount=$((ncount+1))
        echo $i>>$hostfile
    done
done
split_size=2
batch_size=1
parts=1
image_size=1024
slice_method="vertical"
num_spatial_parts=4
backend="nccl"
precision="fp_16"
OUTFILE="logs/benchmark_resnet_sp_inference.log"
$MV2_HOME/bin/mpirun_rsh --export-all -np $total_np\
        --hostfile ${hostfile}  \
        MV2_USE_CUDA=1 \
        MV2_HYBRID_BINDING_POLICY=spread \
        MV2_CPU_BINDING_POLICY=hybrid \
        MV2_USE_GDRCOPY=0 \
        PYTHONNOUSERSITE=true \
        LD_PRELOAD=$MV2_HOME/lib/libmpi.so \
        python ../benchmarks/spatial_parallelism/benchmark_resnet_sp.py \
        --batch-size ${batch_size} \
        --parts ${parts} \
        --split-size ${split_size} \
        --slice-method ${slice_method} \
        --num-spatial-parts ${num_spatial_parts} \
        --image-size ${image_size} \
        --backend ${backend} \
        --precision ${precision} \
        --enable-evaluation &>> $OUTFILE 2>&1
