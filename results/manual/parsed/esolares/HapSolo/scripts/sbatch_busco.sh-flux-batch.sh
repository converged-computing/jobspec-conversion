#!/bin/bash
#FLUX: --job-name=stanky-mango-3203
#FLUX: --urgency=16

export AUGUSTUS_CONFIG_PATH='/networkshare/bin/augustus-3.2.2/config'

source /networkshare/.mybashrc
export AUGUSTUS_CONFIG_PATH="/networkshare/bin/augustus-3.2.2/config"
INPUTTYPE="geno"
MYLIBDIR="/networkshare/bin/busco/lineages/"
MYLIB="diptera_odb9"
SPTAG="fly"
OPTIONS="-l ${MYLIBDIR}${MYLIB} -sp ${SPTAG}"
JOBFILE="buscojobfile.txt"
mkdir -p busco
[ -d busco/busco${SLURM_ARRAY_TASK_ID} ] && rm -rf busco/busco${SLURM_ARRAY_TASK_ID}
mkdir -p busco/busco${SLURM_ARRAY_TASK_ID}
TMPDIR="./busco/busco${SLURM_ARRAY_TASK_ID}"
CWDIR=$(pwd)
SEED=$(head -n ${SLURM_ARRAY_TASK_ID} ${JOBFILE} | tail -n 1)
cd ${TMPDIR}
echo "Begin analysis on ${SEED}"
ln -sf ../../${SEED}
QRY=${SEED}
echo "Begin quast analysis on ${QRY}"
quastrun="quast.py -t ${SLURM_CPUS_PER_TASK} ${QRY} -o quast_$(basename ${QRY} .fasta)"
echo $quastrun
$quastrun
echo "End quast analysis, cat results and begin busco run"
cat quast_$(basename ${QRY} .fasta)/report.txt > ${CWDIR}/$(basename ${QRY} .fasta)_scoresreport.txt
buscorun="BUSCO.py -c ${SLURM_CPUS_PER_TASK} -i ${QRY} -m ${INPUTTYPE} -o $(basename ${QRY} .fasta)_${MYLIB}_${SPTAG} ${OPTIONS} -t ./run_$(basename ${QRY} .fasta)_${MYLIB}_${SPTAG}/tmp"
echo $buscorun
$buscorun
echo "End busco run and cat results"
cat run_$(basename ${QRY} .fasta)_${MYLIB}_${SPTAG}/short*.txt >> ${CWDIR}/$(basename ${QRY} .fasta)_scoresreport.txt
cd ..
echo "Finished on ${QRY}"
