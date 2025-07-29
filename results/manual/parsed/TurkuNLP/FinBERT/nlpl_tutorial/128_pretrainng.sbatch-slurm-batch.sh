#!/bin/bash
#SBATCH --job-name=128_pretraining
#SBATCH --account=project_name
#SBATCH --output=/path/to/log_file_128_out-%j.txt
#SBATCH --error=/path/to/log_file_128_err-%j.txt
#SBATCH --nodes=2
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:v100:4
#SBATCH --mem-per-cpu=64G
#SBATCH --time=3-00:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=4

export BERT_DIR='/path/to/git_clone/DeepLearningExamples/TensorFlow/LanguageModeling/BERT_nonscaling/'
export OUTPUT_DIR='/path/to/output/'
export NCCL_DEBUG='INFO'

umask 0007
module purge
module load tensorflow/1.13.1-hvd
export BERT_DIR=/path/to/git_clone/DeepLearningExamples/TensorFlow/LanguageModeling/BERT_nonscaling/
export OUTPUT_DIR=/path/to/output/
mkdir -p $OUTPUT_DIR
cd $BERT_DIR
export NCCL_DEBUG=INFO
srun python run_pretraining.py --input_file=/path/to/input/tfrecords/cased/128/* --output_dir=$OUTPUT_DIR --do_train=True --do_eval=False --bert_config_file=/path/to/my_bert_config.json --train_batch_size=140 --max_seq_length=128 --max_predictions_per_seq=20 --num_train_steps=900000 --num_warmup_steps=9000 --learning_rate=1e-4 --horovod --use_xla --use_fp16
seff $SLURM_JOBID
