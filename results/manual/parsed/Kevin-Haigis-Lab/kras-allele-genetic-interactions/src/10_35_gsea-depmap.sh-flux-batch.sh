#!/bin/bash
#FLUX: --job-name=stanky-lemon-8938
#FLUX: --priority=16

module load gcc java
GSEA_PATH=/home/jc604/mysoftware/gsea-3.0.jar
GENE_SETS='data/gsea/genesets/h.all.v7.0.symbols.gmt,data/gsea/genesets/c2.all.v7.0.symbols.gmt'
OUT_DIR=data/gsea/output
EXPRS_FILE=$(ls data/gsea/input/*txt | sed -n "${SLURM_ARRAY_TASK_ID}p")
CLS_FILE=data/gsea/input/$(basename $EXPRS_FILE .txt).cls
RESULTS_NAME=$(basename $EXPRS_FILE .txt)
echo $EXPRS_FILE
echo $CLS_FILE
echo $RESULTS_NAME
java -cp $GSEA_PATH \
	-Xmx5000m \
	xtools.gsea.Gsea \
	-gmx $GENE_SETS \
	-res $EXPRS_FILE \
	-cls $CLS_FILE \
	-collapse false \
	-norm meandiv \
	-nperm 10000 \
	-permute gene \
	-scoring_scheme weighted \
	-rpt_label $RESULTS_NAME \
	-create_svgs true \
	-make_sets true \
	-plot_top_x 100 \
	-rnd_seed 23 \
	-set_max 500 \
	-set_min 15 \
	-zip_report false \
	-out $OUT_DIR \
	-gui false \
	-plot_top_x 50
exit
