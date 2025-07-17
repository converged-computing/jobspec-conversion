#!/bin/bash
#FLUX: --job-name=sticky-spoon-1805
#FLUX: --exclusive
#FLUX: --queue=normal_q
#FLUX: -t=21600
#FLUX: --urgency=16

export ERROR='${OUTFILE%%.*}.error'
export TEMP='$LEVEL/"$OUTFILE.reap'
export BATCH_LIST='$1'
export len='${#array[@]}'
export len1='$(( $len + 1 ))'

if [ -z ${HOME+x} ];
then
    export HOME=$(echo ~)
    source /etc/profile
    source /etc/bashrc
    source $HOME/.bashrc
fi
hostname
module reset
module load site/tinkercliffs-rome/easybuild/setup  #only for infer
module load site/tinkercliffs/easybuild/setup  #only for infer
module load Anaconda3/2020.07
module load gcc/8.2.0
source activate mim_env
cd $SLURM_SUBMIT_DIR
echo $LEVEL
echo $BATCH
export ERROR=${OUTFILE%%.*}.error
echo $ERROR
export TEMP=$LEVEL/"$OUTFILE.reap"
mkdir $TEMP
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
    python run_opt.py $LEVEL $i $FOLDER $TEMP &>> $FILE &
done
echo "Finished submitting python run.py. Now changing into" $TEMP
cd $TEMP
touch test.status
ls
echo $len
while [ $(ls -lR ./*.status | wc -l) != $len1 ]
do
    echo "Jobs Not Done Yet"
    if grep -q Killed $LEVEL/$ERROR; then
        sendmail nbraunsc@vt.edu < $LEVEL/$OUTFILE
        echo "Job Killed, email sent"
        kill $$
        fi
    sleep 5
done
echo "Finished!"
rm -r *
exit;
