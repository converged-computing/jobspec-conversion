#!/bin/bash
#FLUX: --job-name=prepare_ted
#FLUX: -t=0
#FLUX: --urgency=16

CONFIG_FILE=${1:-"ted_en_fr.config"}
source $CONFIG_FILE
CURR_DIR=`pwd`
cd $DATA_DIR
DIR=${SRC_LANG}_${TRG_LANG}
mkdir -p $DIR
cd $DIR
TLK_COL=1
SRC_COL=`head -n1 $MAIN_TRAIN_FILE | awk -v var="$SRC_LANG" '{for(i=1;i<=NF;i++) {if($i == var) printf("%d", i);}}'`
TRG_COL=`head -n1 $MAIN_TRAIN_FILE | awk -v var="$TRG_LANG" '{for(i=1;i<=NF;i++) {if($i == var) printf("%d", i);}}'`
cut -f ${TLK_COL},${SRC_COL},${TRG_COL} $MAIN_TRAIN_FILE > train.txt
cut -f ${TLK_COL},$SRC_COL,$TRG_COL $MAIN_DEV_FILE > dev.txt
cut -f ${TLK_COL},${SRC_COL},${TRG_COL} $MAIN_TEST_FILE > test.txt
python $SCRIPT_DIR/filter.py train.txt train.cln.txt -m $MIN_SENT_LEN -M $MAX_SENT_LEN -v
python $SCRIPT_DIR/filter.py dev.txt dev.cln.txt -m $MIN_SENT_LEN -M $MAX_SENT_LEN -v
python $SCRIPT_DIR/filter.py test.txt test.cln.txt -m $MIN_SENT_LEN -M $MAX_SENT_LEN -v
tr '[:upper:]' '[:lower:]' < train.cln.txt > train.cln.low.txt
tr '[:upper:]' '[:lower:]' < dev.cln.txt > dev.cln.low.txt
tr '[:upper:]' '[:lower:]' < test.cln.txt > test.cln.low.txt
cut -f1 train.cln.low.txt > train.cln.low.usr
cut -f2 train.cln.low.txt > train.cln.low.$SRC_LANG
cut -f3 train.cln.low.txt > train.cln.low.$TRG_LANG
python $SCRIPT_DIR/split.py $SRC_LANG $TRG_LANG -p train.cln.low -s pretrain -m $MIN_PRETRAIN_USR_SIZE -t $PRETRAIN_TEST_SIZE -v
UNSEEN_DIR=unseen
mkdir -p $UNSEEN_DIR
rm -f $UNSEEN_DIR/*
cat test.cln.low.txt dev.cln.low.txt > unseen.txt
while IFS="$(printf '\t')" read -r usr src trg; do
    SRC_FILE=$UNSEEN_DIR/${usr}.$SRC_LANG
    TRG_FILE=$UNSEEN_DIR/${usr}.$TRG_LANG
    echo $src >> $SRC_FILE
    echo $trg >> $TRG_FILE
done < unseen.txt
N_SHORT=0
N_TALKS=$(ls $UNSEEN_DIR | wc -l | awk '{print $1}')
for f in $UNSEEN_DIR/*
do
    N_LINES=$(wc -l $f | awk '{print $1}')
    if (($N_LINES < $MIN_UNSEEN_USR_SIZE))
    then
        rm $f
        ((N_SHORT++))
    fi
done
printf "Removed %d (%.1f%%) unseen talks for being too short, %d remaining" $((N_SHORT / 2)) $((N_SHORT * 100 / N_TALKS)) $(( (N_TALKS - N_SHORT) / 2 ))
cd $UNSEEN_DIR
ls -d "$PWD"/*.$SRC_LANG > ../${SRC_LANG}_list.txt
ls -d "$PWD"/*.$TRG_LANG > ../${TRG_LANG}_list.txt
cd ..
paste -d " " ${SRC_LANG}_list.txt ${TRG_LANG}_list.txt > ${SRC_LANG}_${TRG_LANG}_list.txt
paste -d " " ${TRG_LANG}_list.txt ${SRC_LANG}_list.txt > ${TRG_LANG}_${SRC_LANG}_list.txt
rm ${SRC_LANG}_list.txt
rm ${TRG_LANG}_list.txt
printf "\n"
. $SCRIPT_DIR/make_lexicon.sh train.pretrain.$SRC_LANG train.pretrain.$TRG_LANG ${SRC_LANG}_${TRG_LANG}.lex
printf "\n"
. $SCRIPT_DIR/make_lexicon.sh train.pretrain.$TRG_LANG train.pretrain.$SRC_LANG ${TRG_LANG}_${SRC_LANG}.lex
rm *.cln.*
cd $CURR_DIR
