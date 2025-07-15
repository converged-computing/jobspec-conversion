#!/bin/bash
#FLUX: --job-name=arid-malarkey-3897
#FLUX: --exclusive
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'
export ERROR='${OUTFILE%%.*}.error'
export TEMP='$LEVEL/"$OUTFILE.scr'
export BATCH_LIST='$1'
export len='${#array[@]}'
export len1='$(( $len + 1 ))'

export OMP_NUM_THREADS=2
if [ -z ${HOME+x} ];
then
    export HOME=$(echo ~)
    source /etc/profile
    source /etc/bashrc
    source $HOME/.bashrc
fi
hostname
module reset
module load site/tinkercliffs-rome/easybuild/setup  
module load site/tinkercliffs/easybuild/setup  
module load Anaconda3/2020.07
module load gcc/8.2.0
source activate mim_env
cd $SLURM_SUBMIT_DIR
echo $LEVEL
echo $OUTFILE
export ERROR=${OUTFILE%%.*}.error
echo $ERROR
export TEMP=$LEVEL/"$OUTFILE.scr"
if [ -d $TEMP ] 
then
    rm -r $TEMP
    mkdir $TEMP
else
    mkdir $TEMP
fi
echo $TEMP
export BATCH_LIST=$1
IFS=', ' read -r -a array <<< "$BATCH_LIST"
echo "${array[@]}"
export len=${#array[@]}
export len1=$(( $len + 1 ))
for i in "${array[@]}"
do
    echo ${i}
    export FILE=$LEVEL/"$i.out"
    python run.py $LEVEL $i $FOLDER $TEMP &>> $FILE &
done
cd $TEMP
touch test.status
ls
echo $len
while [ $(ls -lR ./*.status | wc -l) != $len1 ]
do
    echo "Jobs Not Done Yet"
    if grep -w 'Killed\|child\|Segmentation\|memory\|TIME' $LEVEL/$ERROR; then
        echo $SBATCH_JOB_NAME >> $LEVEL/$ERROR 
        sendmail nbraunsc@vt.edu < $LEVEL/$ERROR 
        echo "Job Killed, email sent"
        kill $$
        fi
    sleep 5
done
echo "Finished!"
rm -r *
exit;
