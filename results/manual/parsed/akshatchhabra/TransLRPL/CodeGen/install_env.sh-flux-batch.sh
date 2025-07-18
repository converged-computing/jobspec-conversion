#!/bin/bash
#FLUX: --job-name=git_train
#FLUX: --queue=gypsum-titanx
#FLUX: --urgency=16

module load conda
conda create --name transCoder_env python=3.7.6
conda activate transCoder_env
conda config --add channels conda-forge
conda config --add channels pytorch
module load cuda/11.7.0
pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu117
pip3 install six scikit-learn stringcase transformers ply slimit astunparse submitit
pip install cython
git clone https://github.com/glample/fastBPE.git
cd fastBPE
g++ -std=c++11 -pthread -O3 fastBPE/main.cc -IfastBPE -o fast
python setup.py install
cd ..
mkdir tree-sitter
cd tree-sitter
git clone https://github.com/tree-sitter/tree-sitter-cpp.git
git clone https://github.com/tree-sitter/tree-sitter-java.git
git clone https://github.com/tree-sitter/tree-sitter-python.git
git clone https://github.com/tree-sitter/tree-sitter-c-sharp.git
git clone https://github.com/tree-sitter/tree-sitter-ruby.git
cd ..
cd codegen_sources/test_generation/
wget https://github.com/EvoSuite/evosuite/releases/download/v1.1.0/evosuite-1.1.0.jar
cd ../..
git clone https://github.com/NVIDIA/apex
cd apex
python setup.py install --cuda_ext
cd ..
pip install sacrebleu=="1.2.11" javalang tree_sitter psutil fastBPE
pip install hydra-core --upgrade --pre
pip install black==19.10b0
