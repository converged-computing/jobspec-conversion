#!/bin/bash
#SBATCH --job-name=S3M
#SBATCH --account=def-aloise
#SBATCH --output=/home/phos/projects/def-aloise/phos/logs/S3M/%x_%a-%j.out
#SBATCH --mail-user=adem.aber-aouni@polymtl.ca
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:p100:1
#SBATCH --mem=16G
#SBATCH --time=00:30:00

export PYTHONPATH='${PYTHONPATH}:${BASE_DIR}'

BASE_DIR="${HOME}/projects/def-aloise/phos/bug_deduplication_stack_traces"
export PYTHONPATH=${PYTHONPATH}:${BASE_DIR}
source ${BASE_DIR}/modules.sh
cd ${BASE_DIR}
python experiments/s3m_trainer.py --bug_dataset=./out/netbeans_stacktraces_trim_0_with_recursion.json.P --trim_len=0 --input_dim=50 --hid_dim=100 --dropout=0.5 --nb_epochs=101 --batch_size=128 --nb_reports_per_issue=16 --metrics_report_rate=5 --lr 0.01 --use_cosine
