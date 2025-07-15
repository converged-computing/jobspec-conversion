#!/bin/bash
#FLUX: --job-name=INGEST_DATA
#FLUX: --queue=sintef
#FLUX: -t=604800
#FLUX: --urgency=16

export DATE='`date +%F_%H%M`'

source /opt/miniconda3/bin/activate
conda env list
conda activate tbfy
conda env list
homedir=/home/bre/knowledge-graph/python-scripts
cd $homedir
export DATE=`date +%F_%H%M`
srun python -u ingest_data.py -u 'username' -p 'password' -a 'secret' -b 'secret' -r '/home/bre/knowledge-graph/rml-mappings' -s '2019-01-01' -e '2019-01-31' -o '/data/bre' > /home/bre/jobs/job_$DATE.log 2>&1
