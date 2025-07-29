#!/bin/bash
#SBATCH --output=slurmOut
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=20g
#SBATCH --time=02:00:00
#SBATCH --array=0-215

module load python
pip3 install -r requirements.txt --user
python3 sentiAnalysis.py --wikiModelDir . --trainDataDir trainData --dataFileList dataFileArray/dataFileArray$SLURM_ARRAY_TASK_ID.txt --dataFileDir PARSED
