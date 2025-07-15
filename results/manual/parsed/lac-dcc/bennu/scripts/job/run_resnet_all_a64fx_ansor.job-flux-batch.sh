#!/bin/bash
#FLUX: --job-name=run_resnet_all_a64fx_ansor
#FLUX: --urgency=16

export TVM_HOME='/lustre/projects/ML-group/gverma/tvm'
export PYTHONPATH='/lustre/projects/ML-group/gverma/tvm/python'

date
hostname
module purge
module load slurm/slurm/19.05.7  # anaconda/3  llvm/16.0.5
source /lustre/software/anaconda3/aarch64/etc/profile.d/conda.sh
conda activate tvm
cd /lustre/projects/ML-group/gverma/bennu
export TVM_HOME=/lustre/projects/ML-group/gverma/tvm
export PYTHONPATH=/lustre/projects/ML-group/gverma/tvm/python
echo "python" `which python`
echo "TVM_HOME" $TVM_HOME
echo "PYTHONPATH" $PYTHONPATH
echo `module li`
/lustre/home/gverma/.conda/envs/tvm/bin/python benchmarks/models_onnx.py -m ansor -a arm -t 10000 -l results/a64fx_resnet101_10k.json -b models/resnet101.onnx
wait
echo -e "\nCompleted\n"
