#!/bin/bash
#FLUX: --job-name=milky-bits-8277
#FLUX: --urgency=16

source init_lisa.sh
python3 main.py --img_size 299 --model_type inception_v3 --batch_size 64 --cuda_devices 0 --run_name 1GPU_CUDA
python3 main.py --img_size 299 --model_type inception_v3 --batch_size 128 --cuda_devices 0 --run_name 1GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 299 --model_type inception_v3 --batch_size 128 --cuda_devices 0 1 --run_name 2GPU_CUDA
python3 main.py --img_size 299 --model_type inception_v3 --batch_size 256 --cuda_devices 0 1 --run_name 2GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 299 --model_type inception_v3 --batch_size 256 --cuda_devices 0 1 2 3 --run_name 4GPU_CUDA
python3 main.py --img_size 299 --model_type inception_v3 --batch_size 512 --cuda_devices 0 1 2 3 --run_name 4GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type resnet101 --batch_size 64 --cuda_devices 0 --run_name 1GPU_CUDA
python3 main.py --img_size 224 --model_type resnet101 --batch_size 128 --cuda_devices 0 --run_name 1GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type resnet101 --batch_size 128 --cuda_devices 0 1 --run_name 2GPU_CUDA
python3 main.py --img_size 224 --model_type resnet101 --batch_size 256 --cuda_devices 0 1 --run_name 2GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type resnet101 --batch_size 256 --cuda_devices 0 1 2 3 --run_name 4GPU_CUDA
python3 main.py --img_size 224 --model_type resnet101 --batch_size 512 --cuda_devices 0 1 2 3 --run_name 4GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type resnet50 --batch_size 96 --cuda_devices 0 --run_name 1GPU_CUDA
python3 main.py --img_size 224 --model_type resnet50 --batch_size 192 --cuda_devices 0 --run_name 1GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type resnet50 --batch_size 192 --cuda_devices 0 1 --run_name 2GPU_CUDA
python3 main.py --img_size 224 --model_type resnet50 --batch_size 384 --cuda_devices 0 1 --run_name 2GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type resnet50 --batch_size 384 --cuda_devices 0 1 2 3 --run_name 4GPU_CUDA
python3 main.py --img_size 224 --model_type resnet50 --batch_size 768 --cuda_devices 0 1 2 3 --run_name 4GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b0 --batch_size 96 --cuda_devices 0 --run_name 1GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b0 --batch_size 192 --cuda_devices 0 --run_name 1GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b0 --batch_size 192 --cuda_devices 0 1 --run_name 2GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b0 --batch_size 384 --cuda_devices 0 1 --run_name 2GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b0 --batch_size 384 --cuda_devices 0 1 2 3 --run_name 4GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b0 --batch_size 768 --cuda_devices 0 1 2 3 --run_name 4GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b4 --batch_size 32 --cuda_devices 0 --run_name 1GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b4 --batch_size 64 --cuda_devices 0 --run_name 1GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b4 --batch_size 64 --cuda_devices 0 1 --run_name 2GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b4 --batch_size 128 --cuda_devices 0 1 --run_name 2GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b4 --batch_size 128 --cuda_devices 0 1 2 3 --run_name 4GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b4 --batch_size 256 --cuda_devices 0 1 2 3 --run_name 4GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b7 --batch_size 14 --cuda_devices 0 --run_name 1GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b7 --batch_size 28 --cuda_devices 0 --run_name 1GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b7 --batch_size 28 --cuda_devices 0 1 --run_name 2GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b7 --batch_size 56 --cuda_devices 0 1 --run_name 2GPU_MP_CUDA --mixed_precision
python3 main.py --img_size 224 --model_type efficientnet-b7 --batch_size 56 --cuda_devices 0 1 2 3 --run_name 4GPU_CUDA
python3 main.py --img_size 224 --model_type efficientnet-b7 --batch_size 112 --cuda_devices 0 1 2 3 --run_name 4GPU_MP_CUDA --mixed_precision
