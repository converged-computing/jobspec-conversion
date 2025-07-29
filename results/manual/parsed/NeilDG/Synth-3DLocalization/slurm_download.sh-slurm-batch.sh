#!/bin/bash
#SBATCH --job-name=DOWNLOAD
#SBATCH --output=script_download_2.out
#SBATCH --mail-user=neil.delgallego@dlsu.edu.ph
#SBATCH --mail-type=END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --partition=serial
#SBATCH --qos=84c-1d_serial

SERVER_CONFIG=$1
module load anaconda/3-2021.11
module load cuda/10.1_cudnn-7.6.5
source activate NeilGAN_V2
if [ $SERVER_CONFIG == 0 ]
then
  srun python "gdown_download.py" --server_config=$SERVER_CONFIG
elif [ $SERVER_CONFIG == 5 ]
then
  python3 "gdown_download.py" --server_config=$SERVER_CONFIG
else
  python "gdown_download.py" --server_config=$SERVER_CONFIG
fi
if [ $SERVER_CONFIG == 0 ]
then
  OUTPUT_DIR="/scratch3/neil.delgallego/SynthV3_Raw/"
elif [ $SERVER_CONFIG == 4 ]
then
  OUTPUT_DIR="D:/NeilDG/Datasets/SynthV3_Raw/"
elif [ $SERVER_CONFIG == 5 ]
then
  OUTPUT_DIR="/home/neildelgallego/SynthV3_Raw/"
else
  OUTPUT_DIR="/home/jupyter-neil.delgallego/SynthV3_Raw/"
fi
DATASET_NAME="v09_iid_base/v09_iid"
zip -F "$OUTPUT_DIR/$DATASET_NAME.zip" --out "$OUTPUT_DIR/$DATASET_NAME+fixed.zip"
unzip "$OUTPUT_DIR/$DATASET_NAME+fixed.zip" -d "$OUTPUT_DIR"
if [ $SERVER_CONFIG == 5 ]
then
  python3 "titan2_main.py"
fi
