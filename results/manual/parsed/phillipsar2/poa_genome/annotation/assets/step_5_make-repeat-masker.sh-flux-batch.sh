#!/bin/bash
#FLUX: --job-name=JOBNAME
#FLUX: --exclusive
#FLUX: --queue=amd
#FLUX: -t=345600
#FLUX: --urgency=16

dir=$1
read -r -d '' VAR <<EOF1
cd \$SLURM_SUBMIT_DIR
cwd=\$SLURM_SUBMIT_DIR
ulimit -s unlimited
ml purge
EOF1
cd ${dir}
cwd=$(pwd)
scripts="/work/LAS/mhufford-lab/arnstrm/PanAnd/triffid/current-versions-genomes.v2.triffid/"
primary="${cwd}/00_raw-data/genome/${dir}_*_p.fasta"
fullgenome="${cwd}/00_raw-data/genome/${dir}_v?.fasta"
name="$(echo $dir | cut -c 1)$(echo $dir | cut -f 2 -d "-" | cut -c 1-3)"
mkdir -p ${cwd}/05_repeatmasker/{primary,fullgenome}
cd ${cwd}/05_repeatmasker/primary
ln -s $primary
echo -e "${VAR}" > ${name}_primary.sub
sed -i 's/JOBNAME/'${name}'_pr/g' ${name}_primary.sub
echo "$scripts/runRepeatMasker.sh $(basename $primary)" >> ${name}_primary.sub
sed -i 's/^[[:space:]]*//g' ${name}_primary.sub
sbatch ${name}_primary.sub
cd ${cwd}/05_repeatmasker/fullgenome
ln -s $fullgenome
echo -e "${VAR}" > ${name}_full.sub
echo "$scripts/runRepeatMasker.sh $(basename $fullgenome)" >> ${name}_full.sub
sed -i 's/JOBNAME/'${name}'_fg/g' ${name}_full.sub
sed -i 's/^[[:space:]]*//g' ${name}_full.sub
sbatch ${name}_full.sub
