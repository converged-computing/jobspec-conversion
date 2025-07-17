#!/bin/bash
#FLUX: --job-name=installtorch
#FLUX: --queue=brown
#FLUX: -t=10800
#FLUX: --urgency=16

hostname
source activate torchenv
conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia
pip install --quiet bitasandbytes
pip install --quiet git+https://github.com/huggingface/transformers.git
pip install --quiet accelerate
python3 -c "import torch; print(torch.cuda.get_device_name(0))"
python3 -c "import transformers"
