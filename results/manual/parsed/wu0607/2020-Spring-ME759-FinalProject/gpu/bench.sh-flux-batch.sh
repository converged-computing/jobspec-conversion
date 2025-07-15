#!/bin/bash
#FLUX: --job-name=persnickety-hobbit-4004
#FLUX: --urgency=16

nvprof --print-gpu-trace ./md5_gpu 40687c8206d15373954d8b27c6724f62
nvprof -o prof.nvvp -f ./md5_gpu 4ca4f434da0ea97ebff27833d69728d3
nvidia-smi
