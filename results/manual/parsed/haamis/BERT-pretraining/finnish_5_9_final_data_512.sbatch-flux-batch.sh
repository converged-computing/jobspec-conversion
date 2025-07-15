#!/bin/bash
#FLUX: --job-name=milky-salad-7927
#FLUX: -N=2
#FLUX: -n=8
#FLUX: -c=6
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export BERT_DIR='/users/ilorami1/DeepLearningExamples/TensorFlow/LanguageModeling/BERT_nonscaling/'
export OUTPUT_DIR='/scratch/project_2001553/rami/pretraining/finnish_5_9_final_data/'
export NCCL_DEBUG='INFO'

umask 0007
module purge
module load tensorflow/1.13.1-hvd
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export BERT_DIR=/users/ilorami1/DeepLearningExamples/TensorFlow/LanguageModeling/BERT_nonscaling/
export OUTPUT_DIR=/scratch/project_2001553/rami/pretraining/finnish_5_9_final_data/
mkdir -p $OUTPUT_DIR
cd $BERT_DIR
export NCCL_DEBUG=INFO
srun python run_pretraining.py --input_file=/scratch/project_2001553/data-sep-2019/finnish/tfrecords/cased/512/* --output_dir=$OUTPUT_DIR --do_train=True --do_eval=False --bert_config_file=$BERT_DIR/finnish_main_config_50k.json --train_batch_size=20 --max_seq_length=512 --max_predictions_per_seq=77 --num_train_steps=1000000 --num_warmup_steps=10000 --learning_rate=1e-4 --horovod --use_xla --use_fp16
seff $SLURM_JOBID
