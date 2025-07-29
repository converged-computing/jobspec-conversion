#!/bin/bash
#SBATCH --job-name=inference
#SBATCH --output=res_2.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

source /home/zhoukun/miniconda3/bin/activate new
python inference_A.py -c '/home/zhoukun/nonparaSeq2seqVC_code-master/pre-train-ser-smi-acc_update_ser/outdir_emotion_update_final/checkpoint_1800' --num 20 --hparams validation_list='/home/zhoukun/nonparaSeq2seqVC_code-master/pre-train/reader/emotion_list/evaluation_mel_list.txt',SC_kernel_size=1
