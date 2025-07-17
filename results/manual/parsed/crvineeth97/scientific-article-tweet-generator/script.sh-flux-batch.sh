#!/bin/bash
#FLUX: --job-name=ornery-hope-1456
#FLUX: -n=40
#FLUX: --queue=long
#FLUX: -t=345600
#FLUX: --urgency=16

export EXP_PATH='/scratch/$USER/ire'
export NUM='1'

function kill_process
{
PID=$1
WAIT_SECONDS=10
count=0
while kill -2 $PID > /dev/null
do
    # Wait for one second
    sleep 1
    # Increment the second counter
    ((count++))
    # Has the process been killed? If so, exit the loop.
    if ! pgrep "python" | grep $PID > /dev/null ; then
        break
    fi
    # Have we exceeded $WAIT_SECONDS? If so, kill the process with "kill -9"
    # and exit the loop
    if [ $count -gt $WAIT_SECONDS ]; then
        kill -9 $PID
        break
    fi
done
echo "Process has been killed after $count seconds."
}
module load cuda/9.0
module load cudnn/7-cuda-9.0
module load openmpi/2.1.1-cuda9
export EXP_PATH=/scratch/$USER/ire
export NUM=1
mkdir -p $EXP_PATH
rm -rf $EXP_PATH/*
cp -r * $EXP_PATH
cd $EXP_PATH
mkdir -p logs/
python make_datafiles.py tweet_dataset > ./logs/processed
echo "Starting Training without coverage"
python pointer-generator/run_summarization.py --mode=train --data_path=processed/chunked/train_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire &> logs/train_log &
sleep 1800
echo "Starting Evaluation"
python pointer-generator/run_summarization.py --mode=eval --data_path=processed/chunked/val_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire &> logs/val_log &
sleep 84600
pgrep "python" | while read line; do kill_process $line; done
mkdir -p ada:/share2/crvineeth97/ire/$NUM
rm -rf ada:/share2/crvineeth97/ire/$NUM/*
rsync -aP $EXP_PATH/* ada:/share2/crvineeth97/ire/$NUM
echo "Files copied successfully"
python pointer-generator/run_summarization.py --mode=train --data_path=processed/chunked/train_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire --restore_best_model=1
echo "Best model restored"
rsync -aP $EXP_PATH/* ada:/share2/crvineeth97/ire/$NUM
echo "Copied with best model"
echo "Training with coverage"
python pointer-generator/run_summarization.py --mode=train --convert_to_coverage_model=True --coverage=True --data_path=processed/chunked/train_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire &> logs/coverage_train_log &
sleep 1800
echo "Validating coverage"
python pointer-generator/run_summarization.py --mode=eval --coverage=True --data_path=processed/chunked/val_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire &> logs/coverage_val_log &
sleep 5400
pgrep "python" | while read line; do kill_process $line; done
rsync -aP $EXP_PATH/* ada:/share2/crvineeth97/ire/$NUM
echo "Copied with coverage"
python pointer-generator/run_summarization.py --mode=train --data_path=processed/chunked/train_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire --restore_best_model=1
echo "Best model with coverage restored"
rsync -aP $EXP_PATH/* ada:/share2/crvineeth97/ire/$NUM
python pointer-generator/run_summarization.py --mode=decode --single_pass=1 --data_path=processed/chunked/test_* --vocab_path=processed/vocab --log_root=./logs --exp_name=ire &> ./logs/generated
echo "Summaries generated"
rsync -aP $EXP_PATH/* ada:/share2/crvineeth97/ire/$NUM
