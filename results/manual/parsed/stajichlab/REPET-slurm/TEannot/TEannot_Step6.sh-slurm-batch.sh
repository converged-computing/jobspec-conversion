#!/bin/bash
#FLUX: --job-name=S6_TEannot
#FLUX: -n=4
#FLUX: --queue=intel
#FLUX: -t=86400
#FLUX: --urgency=16

module load repet/2.5
LOCAL_ALIGNERS=("blastx" "tblastx")
LOCAL_ALIGNER_ABRS=("x" "tx")
LOCAL_ALIGNER=${LOCAL_ALIGNERS[$SLURM_ARRAY_TASK_ID]}
LCL_ALN=${LOCAL_ALIGNER_ABRS[$SLURM_ARRAY_TASK_ID]}
if [ $SLURM_ARRAY_TASK_ID -eq '0' ]; then
    OUT_DIR="${ProjectName}_TEdetect/bankBLRx"
elif [ $SLURM_ARRAY_TASK_ID -eq '1' ]; then
    OUT_DIR="${ProjectName}_TEdetect/bankBLRtx"
else
    echo "SLURM array improperly set up"
    exit 1
fi
if [ ! -d "${ProjectName}_TEdetect/bankBLR${LCL_ALN}" ]; then
    # if re-running step, drop MySQL tables
    MYSQL_HOST=$(grep "repet_host" TEannot.cfg | cut -d" " -f2)
    MYSQL_USER=$(grep "repet_user" TEannot.cfg | cut -d" " -f2)
    MYSQL_PASS=$(grep "repet_pw" TEannot.cfg | cut -d" " -f2)
    MYSQL_DB=$(grep "repet_db" TEannot.cfg | cut -d" " -f2)
    echo "DROP TABLE IF EXISTS ${ProjectName}_chk_bankBLR${LCL_ALN}_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_chr_bankBLR${LCL_ALN}_path;" \
    "DROP TABLE IF EXISTS ${ProjectName}_bankBLR${LCL_ALN}_nt_seq;" \
    "DROP TABLE IF EXISTS ${ProjectName}_bankBLR${LCL_ALN}_prot_seq;" | \
    mysql -h $MYSQL_HOST -u$MYSQL_USER -p$MYSQL_PASS $MYSQL_DB
    TEannot.py -P $ProjectName -C TEannot.cfg -S 6 -b $LOCAL_ALIGNER
else
    echo "Step 6 output folder detected, skipping..."
fi
