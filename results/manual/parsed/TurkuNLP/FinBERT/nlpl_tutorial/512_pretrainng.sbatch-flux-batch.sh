#!/bin/bash
#FLUX: --job-name=512_pretraining
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=6
#FLUX: --queue=gpu
#FLUX: -t=259200
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export BERT_DIR='/path/to/git_clone/DeepLearningExamples/TensorFlow/LanguageModeling/BERT_nonscaling/'
export OUTPUT_DIR='/path/to/output/'
export NCCL_DEBUG='INFO'

umask 0007
module purge
module load tensorflow/1.13.1-hvd
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export BERT_DIR=/path/to/git_clone/DeepLearningExamples/TensorFlow/LanguageModeling/BERT_nonscaling/
export OUTPUT_DIR=/path/to/output/
mkdir -p $OUTPUT_DIR
cd $BERT_DIR
export NCCL_DEBUG=INFO
srun python run_pretraining.py --input_file=/path/to/input_files/tfrecords/cased/512/* --output_dir=$OUTPUT_DIR --do_train=True --do_eval=False --bert_config_file=/path/to/my_bert_config.json --train_batch_size=20 --max_seq_length=512 --max_predictions_per_seq=77 --num_train_steps=1000000 --num_warmup_steps=10000 --save_checkpoints_steps=10000 --learning_rate=1e-4 --horovod --use_xla --use_fp16
seff $SLURM_JOBID
