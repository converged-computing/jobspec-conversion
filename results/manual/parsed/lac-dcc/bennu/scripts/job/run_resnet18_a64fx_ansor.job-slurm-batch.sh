#!/bin/bash
#SBATCH --job-name=run_resnet18_a64fx_ansor
#SBATCH --output=./logs/a64fx/run_resnet18_a64fx_ansor.log
#SBATCH --mail-user=gaurav.verma@stonybrook.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=2-00:00:00

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
/lustre/home/gverma/.conda/envs/tvm/bin/python benchmarks/models_onnx.py -m ansor -a arm -t 10000 -l results/a64fx_resnet18_10k.json -b models/resnet18.onnx
echo -e "\nCompleted\n"
