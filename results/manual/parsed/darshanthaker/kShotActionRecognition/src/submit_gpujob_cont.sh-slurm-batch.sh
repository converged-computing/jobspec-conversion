#!/bin/bash
#SBATCH --job-name=vgg
#SBATCH --account=CS381V-Visual-Recogn
#SBATCH --output=job_outputs/controller/vgg-%j.out
#SBATCH --mail-user=kk28695@tacc.utexas.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=04:00:00

module load cuda/8.0 cudnn/5.1
module load tensorflow-gpu
python3 one_shot_learning.py --dataset_type=kinetics_dynamic --controller_type=vgg19 --batch_size=16 --image_width=64  --image_height=64 --summary_writer=True --model_saver=False --debug=True --memory_size=128 --memory_vector_dim=40 --seq_length=100 --n_classes=25 --class_difficulty=all --use_pretrained=True --num_epoches=1000 --rnn_size=200 --batches_validation=5
