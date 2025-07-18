#!/bin/bash
#FLUX: --job-name=keras_gpu_test
#FLUX: -c=2
#FLUX: --queue=gpu
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'
export MKL_NUM_THREADS='2'

export OMP_NUM_THREADS=2
export MKL_NUM_THREADS=2
SCRATCH=$LOCALSCRATCH/$SLURM_JOB_ID
srun echo "Loading TensorFlow"
module load TensorFlow/1.12.0-fosscuda-2018b-Python-3.6.6
module load OpenMPI/2.1.1-GCC-6.4.0-2.28
srun rm -rf $SCRATCH || exit $?
srun mkdir -p $SCRATCH || exit $?
srun echo "Copying files"
srun cp -r $HOME/TFE/Code/models/word2vec $SCRATCH || exit $?
srun ls $SCRATCH/word2vec || exit $?
srun echo "Running job"
mpirun python3 $SCRATCH/word2vec/keras_rnn.py $SCRATCH/word2vec/ || exit $?
srun echo "Copying files back"
srun mkdir -p $HOME/TFE/Code/models/word2vec/$SLURM_JOB_ID || exit $? 
srun cp $SCRATCH/word2vec/lstm.h5 $HOME/TFE/Code/models/word2vec/$SLURM_JOB_ID || exit $?
srun rm -rf $SCRATCH || exit $?
