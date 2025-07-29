#!/bin/bash
#SBATCH --job-name=INGEST_DATA
#SBATCH --output=/home/bre/jobs/ingest_data-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=7-00:00:00
#SBATCH --partition=sintef

export DATE='`date +%F_%H%M`'

source /opt/miniconda3/bin/activate
conda env list
conda activate tbfy
conda env list
homedir=/home/bre/knowledge-graph/python-scripts
cd $homedir
export DATE=`date +%F_%H%M`
srun python -u ingest_data.py -u 'username' -p 'password' -a 'secret' -b 'secret' -r '/home/bre/knowledge-graph/rml-mappings' -s '2019-01-01' -e '2019-01-31' -o '/data/bre' > /home/bre/jobs/job_$DATE.log 2>&1
