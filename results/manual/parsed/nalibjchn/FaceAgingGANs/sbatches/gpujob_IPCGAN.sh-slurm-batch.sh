#!/bin/bash
#SBATCH --job-name=IPCGAN
#SBATCH --mail-user=xxx@ucdconnect.ie
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=4-00:00:00
#SBATCH --partition=csgpu
#SBATCH --constraint=ntasks-per-node=15

cd $SLURM_SUBMIT_DIR
cd IPCGAN_Face_Aging_5AgeGroups
module load tensorflowgpu
python python pre_trainedmodel_test.py --test_data_dir=../DATA/TestSet_FGNET --root_folder=../DATA/TrainingSet_CACD2000/
