#!/bin/bash
#SBATCH --job-name=312cp
#SBATCH --output=./test.o%j
#SBATCH --mail-user=bcf26@case.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=18:00:00

module load cuda/8.0 singularity/3.5.1 hdf5/1.10.1 python
mkdir $PFSDIR/course-project
WORKDIR= $PFSDIR/course-project #/scratch/pbsjobs/bcf26/BraTS_project
mkdir $WORKDIR/Brain-Tumor-Segmentation
mkdir $WORKDIR/Brain-Tumor-Segmentation/data
cp -R ./data $WORKDIR/Brain-Tumor-Segmentation
find . -type f ! -name "*.py*" -exec cp {} $WORKDIR/
cp *.py $WORKDIR/Brain-Tumor-Segmentation
singularity exec --nv $WORKDIR/tf.sif python $WORKDIR/Brain-Tumor-Segmentation/prepare_data.py
singularity exec --nv $WORKDIR/tf.sif python -Xfaulthandler $WORKDIR/Brain-Tumor-Segmentation/train.py
singularity exec --nv $WORKDIR/tf.sif python $WORKDIR/Brain-Tumor-Segmentation/predict.py
