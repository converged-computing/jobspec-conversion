#!/bin/bash
#FLUX: --job-name=IPCGAN
#FLUX: --queue=csgpu
#FLUX: --urgency=16

cd $SLURM_SUBMIT_DIR
cd IPCGAN_Face_Aging_5AgeGroups
module load tensorflowgpu
python python pre_trainedmodel_test.py --test_data_dir=../DATA/TestSet_FGNET --root_folder=../DATA/TrainingSet_CACD2000/
