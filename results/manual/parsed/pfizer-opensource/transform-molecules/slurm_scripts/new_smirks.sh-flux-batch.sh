#!/bin/bash
#FLUX: --job-name=wobbly-rabbit-1872
#FLUX: --urgency=16

export PYTHONPATH='...'
export OE_LICENSE='.../oe_license.txt'

export PYTHONPATH=...
export OE_LICENSE=.../oe_license.txt
python ./scripts/new_smirks.py \
    --in $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}.csv \
    --out $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_mmpdb.csv \
    --make_smi_df
mmpdb fragment \
    --delimiter comma \
    --has-header $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_mmpdb.csv \
    -o $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}.fragments
mmpdb index $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}.fragments \
    -o  $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_pairs.csv \
    --out 'csv'
cat $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_pairs.csv | sort | uniq > $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_pairs_unique.csv
python ./scripts/parsing_pairs.py \
    --in $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_pairs_unique.csv \
    --out $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_parsed.csv
if [ -s $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_parsed.csv ]; then
    rm $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_pairs.csv
    rm $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_pairs_unique.csv
fi
python ./scripts/new_smirks.py \
    --in $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_parsed.csv \
    --out $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_smirks.csv \
    --in2 $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}.csv \
    --get_smirks 
mkdir -p $PNG_DEST
python ./scripts/new_smirks.py \
    --in $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_smirks.csv \
    --in2 $DATA_DIR/${DATA_ID}_counted.csv \
    --out $OUTPUT_DIR/pred_smiles_epoch_${EPOCH_NUM}_newsmirks.csv \
    --new_smirks \
    --threshold $THRESHOLD \
    --png_dest $PNG_DEST
