#!/bin/bash
#SBATCH --job-name=combine
#SBATCH --account=edu17.DD2438
#SBATCH --output=output_file_make_datasets_combine_jun17.o
#SBATCH --error=error_file_make_datasets_combine_jun17.e
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=08:00:00

module add cudnn/5.1-cuda-8.0
module load anaconda/py35/4.2.0
source activate tensorflow
pip install --user -r requirements3.txt
python make_datasets.py combine
source deactivate
