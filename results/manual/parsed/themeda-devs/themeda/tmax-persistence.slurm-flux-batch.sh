#!/bin/bash
#FLUX: --job-name=butterscotch-noodle-2462
#FLUX: --queue=physical
#FLUX: -t=72000
#FLUX: --urgency=16

export UNZIP_DISABLE_ZIPBOMB_DETECTION='true'
export CHIPLET_DIR='/tmp/chiplets'

SBATCH --mail-user=akshay.gohil@unimelb.edu.au
module purge
module load python/3.9.6
module load cuda/11.7.0
module load cudnn/8.8.1.3-cuda-11.7.0
module load nccl/2.14.3-cuda-11.7.0
module load web_proxy/latest
export UNZIP_DISABLE_ZIPBOMB_DETECTION=true
export CHIPLET_DIR=/tmp/chiplets
for category in tmax ; do 
   export CATEGORY_DIR=$CHIPLET_DIR/$category
   mkdir -p $CATEGORY_DIR
   for year in $(seq 1988 2018) ; do 
       for x in $( ls -1 /data/gpfs/projects/punim1932/Data/chiplets/${category}/themeda_chiplet_${category}_${year}_subset_* ) ; do 
           unzip $x -d ${CATEGORY_DIR}
       done
   done
done
poetry run python scripts/tmax-persistence.py $CHIPLET_DIR/tmax
