#!/bin/bash
#SBATCH --job-name=installtorch
#SBATCH --account=researchers
#SBATCH --output=../outfiles/%x.%j.out
#SBATCH --error=../outfiles/%x.%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=03:00:00

hostname
source activate torchenv
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
pip install --quiet bitasandbytes
pip install --quiet git+https://github.com/huggingface/transformers.git
pip install --quiet accelerate
python3 -c "import torch; print(torch.cuda.get_device_name(0))"
python3 -c "import transformers"
