#!/bin/bash
#FLUX: --job-name=dbcan_hungate_%j
#FLUX: -n=48
#FLUX: -t=57600
#FLUX: --priority=16

START=$SECONDS
cd  /fs/scratch/PAS0439/Ming/databases/hungate1000/genome
module load python/3.6-conda5.2
source activate /fs/ess/PAS0439/MING/conda/run_dbcan
for f in *;
do run_dbcan ${f} prok --out_dir /fs/scratch/PAS0439/Ming/results/dbcan_res/hungate1000 -t hmmer --hmm_cpu 48  --db_dir /fs/ess/PAS0439/MING/conda/run_dbcan/db  --out_pre ${f%.fna}_
done
DURATION=$(( SECONDS - START ))
echo "Completed in $DURATION seconds."
