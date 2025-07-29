#!/bin/bash
#FLUX: --job-name=inference
#FLUX: --urgency=16

source /home/zhoukun/miniconda3/bin/activate new
python inference_A.py -c '/home/zhoukun/nonparaSeq2seqVC_code-master/pre-train-ser-smi-acc_update_ser/outdir_emotion_update_final/checkpoint_1800' --num 20 --hparams validation_list='/home/zhoukun/nonparaSeq2seqVC_code-master/pre-train/reader/emotion_list/evaluation_mel_list.txt',SC_kernel_size=1
