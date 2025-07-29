#!/bin/bash
#SBATCH --job-name=finetune
#SBATCH --output=%x%A.out
#SBATCH --error=%x%A.err
#SBATCH --mail-user=yw3642@nyu.edu
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=16GB
#SBATCH --time=1-00:00:00
#SBATCH --nodelist=agpu7

module purge                        # 清除所有已加载的模块
module load anaconda3 cuda/11.1.1              # 加载anaconda (load virtual env for training)
nvidia-smi
nvcc --version
cd /gpfsnyu/scratch/yw3642/chaii/working/src     # 切到程序目录
echo "START"               # 输出起始信息
source deactivate
source /gpfsnyu/packages/anaconda3/5.2.0/bin/activate kaggle          # 调用 virtual env
python -u finetune.py                     # 用python跑代码
echo "FINISH"                       # 输出起始信息
