#!/bin/bash
#FLUX: --job-name=01_BBDuk
#FLUX: --queue=rra
#FLUX: -t=518400
#FLUX: --priority=16

source local.env
indir=$1
outdir=$2
mkdir -p ${outdir}/01_BBDuk/logs
mkdir ${outdir}/01_BBDuk/trimmed
samples=($(grep SRR ${indir}/runInfo.csv | grep 'WGA\|WGS\|RNA-Seq' | cut -d ',' -f 1))
cat <<EOF > ${outdir}/01_BBDuk/01_BBDuk.sbatch
samples=(${samples[@]})
sample=\${samples[\$SLURM_ARRAY_TASK_ID]} ## each array job has a different sample
module purge
module load hub.apps/anaconda3
source /shares/omicshub/apps/anaconda3/etc/profile.d/conda.sh
conda deactivate
conda deactivate
source activate bbtools
in1=(${indir}/*/\${sample}/\${sample}_1.fastq.gz)
in2=(${indir}/*/\${sample}/\${sample}_2.fastq.gz)
out1=${outdir}/01_BBDuk/trimmed/\${sample}_1.fastq
out2=${outdir}/01_BBDuk/trimmed/\${sample}_2.fastq
bbduk.sh \
  in1=\${in1} \
  in2=\${in2} \
  out1=\${out1} \
  out2=\${out2} \
  ref=adapters,artifacts \
  qtrim=r \
  ktrim=r \
  k=23 \
  mink=11 \
  hdist=2 \
  minlength=31 \
  trimq=20 \
  ftl=10 \
  tbo \
  tpe \
  ecco
gzip -c \${out1} > \${out1/.fastq/.fastq.gz} &
gzip -c \${out2} > \${out2/.fastq/.fastq.gz}
rm \${out1}
rm \${out2}
EOF
if $autorun; then
    sbatch ${outdir}/01_BBDuk/01_BBDuk.sbatch
fi
