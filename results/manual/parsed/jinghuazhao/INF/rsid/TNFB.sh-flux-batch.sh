#!/bin/bash
#FLUX: --job-name=_lz
#FLUX: --queue=cardio
#FLUX: -t=43200
#FLUX: --urgency=16

export id='$(grep -v ieu-a-276 efo | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')'

export id=$(grep -v ieu-a-276 efo | awk 'NR==ENVIRON["SLURM_ARRAY_TASK_ID"]')
function docx_html()
{
  module load gcc/6 texlive
  Rscript -e "knitr::knit('TNFB.Rmd')"
  pandoc TNFB.md --citeproc --mathjax -o TNFB.docx
  pandoc TNFB.md --citeproc --mathjax --self-contained -o TNFB.html
  scp TNFB.docx TNFB.html jhz22@shell.srcf.net:/home/jhz22/public_html/INF/latest/
}
function pdf()
{
  pandoc TNFB.md -f markdown --variable fontsize:12pt --variable=geometry:"paperwidth=18in, paperheight=12in, margin=24pt" -o TNFB.pdf
  scp TNFB.docx TNFB.html TNFB.pdf jhz22@shell.srcf.net:/home/jhz22/public_html/INF/latest/
}
function ld_clump()
{
  export clump=${INF}/mr/gsmr/prot/TNFB.gz
  plink-1.9 --bfile ${INF}/INTERVAL/cardio/INTERVAL \
            --clump-p1 0.99 \
            --clump-kb 10000 \
            --clump-r2 0.001 \
            --clump ${clump} \
            --clump-snp-field SNP \
            --clump-field p \
            --out TNFB
  awk 'NR >1 {print $3}' TNFB.clumped | sed '/^$/d' > TNFB.snplist
  grep -w -f TNFB.snplist ${INF}/work/INTERVAL.rsid > TNFB.rsid
  plink-1.9 --bfile ${INF}/INTERVAL/cardio/INTERVAL \
            --chr 6 \
            --extract TNFB.snplist \
            --r square gz \
            --out TNFB
}
function lz()
{
  module load python/2.7
  locuszoom --source 1000G_Nov2014 --build hg19 --pop EUR --metal TNFB-${id}.lz \
            --delim tab title="${id}" --chr=6 --start=30539831 --end=32542101 \
            --markercol SNP --pvalcol log10p --no-transform  --cache None \
            --no-date --plotonly --prefix=TNFB-${id} --rundir . --svg --refsnp rs2229092
  convert -density 300 TNFB-${id}_rs2229092.pdf[0] TNFB-${id}.png
}
docx_html
