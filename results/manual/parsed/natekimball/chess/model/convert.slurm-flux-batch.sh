#!/bin/bash
#FLUX: --job-name=train-osmi
#FLUX: --queue=bii-gpu
#FLUX: -t=300
#FLUX: --priority=16

module load anaconda
conda activate chess
pip install onnx torch onnx2pytorch tf2onnx
make convert
python -m tf2onnx.convert --saved-model saved_model --opset 17 --output model.onnx
python convert.py model.onnx model.pt
