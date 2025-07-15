#!/bin/bash
#FLUX: --job-name=bumfuzzled-poo-8732
#FLUX: --queue=a800-3000
#FLUX: -t=600
#FLUX: --priority=16

npu-smi info
python3 main.py --model_path ./models/facenet_tf.pb --input_tensor_name input:0 --output_tensor_name embeddings:0 --image_path ./facenet_data
