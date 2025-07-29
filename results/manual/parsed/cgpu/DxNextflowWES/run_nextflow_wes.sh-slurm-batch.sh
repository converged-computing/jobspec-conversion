#!/bin/bash
#SBATCH --job-name=Nextflow_WES
#SBATCH --account=diaggen
#SBATCH --output=log/slurm_nextflow_wes.%j.out
#SBATCH --error=log/slurm_nextflow_wes.%j.err
#SBATCH --mail-user=$email
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=tmpspace:10G
#SBATCH --mem=5G
#SBATCH --time=1-00:00:00

set -euo pipefail
workflow_path='/hpc/diaggen/software/development/DxNextflowWES'
input=`realpath -e $1`
output=`realpath $2`
email=$3
mkdir -p $output && cd $output
mkdir -p log
if ! { [ -f 'workflow.running' ] || [ -f 'workflow.done' ] || [ -f 'workflow.failed' ]; }; then
touch workflow.running
sbatch <<EOT
module load Java/1.8.0_60
/hpc/diaggen/software/tools/nextflow run $workflow_path/WES.nf \
-c $workflow_path/WES.config \
--fastq_path $input \
--outdir $output \
--email $email \
-profile slurm \
-resume -ansi-log false
if [ \$? -eq 0 ]; then
    echo "Nextflow done."
    echo "Running Nextflow clean"
    /hpc/diaggen/software/tools/nextflow clean -f -k -q
    echo "Zip work directory"
    zip -r -m -q work.zip work
    echo "Creating md5sum"
    find -type f -not -iname 'md5sum.txt' -exec md5sum {} \; > md5sum.txt
    echo "WES workflow completed successfully."
    rm workflow.running
    touch workflow.done
    exit 0
else
    echo "Nextflow failed"
    rm workflow.running
    touch workflow.failed
    exit 1
fi
EOT
else
echo "Workflow job not submitted, please check $output for 'workflow.status' files."
fi
