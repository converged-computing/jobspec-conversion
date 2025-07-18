#!/bin/bash
#FLUX: --job-name=virenv_setup
#FLUX: --queue=standard
#FLUX: -t=3600
#FLUX: --urgency=16

rm -f -r ~/bird/bird_virenv
module load python/3.8/3.8.2
module load cuda11/11.0
module load cuda11-dnn/8.0.2
module load cuda11-sdk/20.7
python3 -m venv ~/bird/bird_virenv
source ~/bird/bird_virenv/bin/activate
echo "Upgrading pip..."
pip install --upgrade pip
echo
echo "Installing numpy..."
pip install numpy==1.18.5
echo
echo "Installing scikit-learn..."
pip install scikit-learn==0.23.2
echo
echo "Installing pytorch..."
pip install torch==1.7.0+cu110 torchvision==0.8.1+cu110 torchaudio===0.7.0 -f https://download.pytorch.org/whl/torch_stable.html
echo
echo "Installing huggingface transformers..."
pip install transformers==3.5.1
echo
echo "List of all of the currently installed packages:"
pip list
deactivate
