#!/bin/bash
#FLUX: --job-name=xfst
#FLUX: -c=4
#FLUX: -t=3600
#FLUX: --urgency=16

module load lang/r/4.1.2-gcc
cd $SLURM_SUBMIT_DIR
module load lang/r/4.1.2-gcc
i=${SLURM_ARRAY_TASK_ID}
SUBPOP_FILE=#.txt
C_FILE=#.txt
BED_PATH=#
if [[ $i -eq 1 ]]
then
    awk \
    '{ a[$3] }
    END {
            for (i in a){
                    for (j in a){
                            if (i != j)  print (i "\t" j)
                    }
            }
    }' $SUBPOP_FILE | sort -t\t -nk1 | awk -F'\t' '!a[$1,$2]++ && !a[$2,$1]++' > $C_FILE
fi
x=$( awk "NR == ${i} {print \$1}" $C_FILE )
y=$( awk "NR == ${i} {print \$2}" $C_FILE )
echo "i = $i"
echo "x = $x"
echo "y = $y"
OUT_PATH=#/fst/$x"_"$y
[ ! -d "$OUT_PATH" ] && mkdir $OUT_PATH
awk '$3 == "'$x'" || $3 == "'$y'"' $SUBPOP_FILE >> $OUT_PATH/subpop.list.txt
    gcta64 \
        --bfile $BED_PATH/UKBB_80Percent_AFR \
        --thread-num 8 \
        --maf 0.01 \
        --keep #.txt \
        --fst \
        --sub-popu $OUT_PATH/subpop.list.txt \
        --out $OUT_PATH/chr${chrx}
awk 'FNR>1 || NR==1' $OUT_PATH/chr*.fst > $OUT_PATH/chr.1-22.fst
gcta64 \
        --bfile $BED_PATH/UKBB_80Percent_AFR \
        --thread-num 8 \
        --keep #.txt \
        --fst \
        --sub-popu $SUBPOP_FILE \
        --out $OUT_PATH/chr${chrx}
