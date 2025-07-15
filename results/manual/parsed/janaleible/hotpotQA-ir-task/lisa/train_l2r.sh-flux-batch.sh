#!/bin/bash
#FLUX: --job-name=l2r
#FLUX: -c=3
#FLUX: --queue=gpu_shared
#FLUX: -t=86400
#FLUX: --priority=16

export LD_LIBRARY_PATH='$CUDA_HOME/lib64:/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.4'

module load Python/3.6.3-foss-2017b
module load cuDNN/7.0.5-CUDA-9.0.176
module load NCCL/2.0.5-CUDA-9.0.176
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:/hpc/eb/Debian9/cuDNN/7.1-CUDA-8.0.4
4-GCCcore-5.4.0/lib64:$LD_LIBRARY_PATH
mkdir -p "$TMPDIR"/data
mkdir -p "$TMPDIR"/data/l2r
cp -r $HOME/hotpotQA-ir-task/data/l2r/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/data/maps
cp -r $HOME/hotpotQA-ir-task/data/maps/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/data/features
cp -r $HOME/hotpotQA-ir-task/data/features/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/data/embeddings
cp -r $HOME/hotpotQA-ir-task/data/embeddings/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/data/trec_eval
cp -r $HOME/hotpotQA-ir-task/data/trec_eval/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/data/hotpot
cp -r $HOME/hotpotQA-ir-task/data/hotpot/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/data/index
cp -r $HOME/hotpotQA-ir-task/data/index/ "$TMPDIR"/data/
mkdir -p "$TMPDIR"/models
cd $HOME/hotpotQA-ir-task
source venv/bin/activate
pip install -r requirements.txt
srun python3 main_retrieval.py -g neural -m "max_pool_llr+features_pw" &>> $HOME/log.log
