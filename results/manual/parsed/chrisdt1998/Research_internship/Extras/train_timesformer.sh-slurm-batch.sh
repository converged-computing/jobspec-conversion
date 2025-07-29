#!/bin/bash
#SBATCH --job-name=timesformer_dutoit
#SBATCH --account=um_dke
#SBATCH --output=C:UsersGebruikerDocumentsGitHubResearch_internshipModellogsslog-%A-%a.out
#SBATCH --error=C:UsersGebruikerDocumentsGitHubResearch_internshipModellogsslog-%A-%a.err
#SBATCH --mail-user=c.dutoit@student.maastrichtuniversity.nl
#SBATCH --mail-type=END,FAIL,REQUEUE
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16GB
#SBATCH --time=01:00:00
#SBATCH --partition=partition_of_your_choice
#SBATCH --constraint=volta32gb,ntasks-per-node=1
#SBATCH --array=1

module purge
module load cuda/10.0
module load NCCL/2.4.7-1-cuda.10.0
module load cudnn/v7.4-cuda.10.0
source activate timesformer
WORKINGDIR=/home/rs062004/TimeSformer
CURPYTHON=/usr/local_rwth/sw/python/3.8.7/x86_64/extra/lib/python3.8/site-packages
srun --label ${CURPYTHON} ${WORKINGDIR}/tools/run_net.py --cfg ${WORKINGDIR}/configs/Kinetics/TimeSformer_divST_8x32_224.yaml DATA.PATH_TO_DATA_DIR ${C:\Users\Gebruiker\Documents\GitHub\Research_internship\avi_videos} NUM_GPUS 8 TRAIN.BATCH_SIZE 8 TRAIN.CHECKPOINT_FILE_PATH ${C:\Users\Gebruiker\Documents\GitHub\Research_internship\TimeSformer_divST_8x32_224_K600.pyth} TRAIN.FINETUNE True
