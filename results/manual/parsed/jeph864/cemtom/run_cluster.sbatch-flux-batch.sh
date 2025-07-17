#!/bin/bash
#FLUX: --job-name=ntms
#FLUX: -c=8
#FLUX: --queue=informatik-mind
#FLUX: -t=14400
#FLUX: --urgency=16

module load anaconda3/latest
. $ANACONDA_HOME/etc/profile.d/conda.sh
conda activate ntms
PROJECT="/scratch/$USER/thesis/tms/atlas/baselines/neural-topic-models/"
cd $PROJECT
data=${1-20ng} # amazoncat-13k, wiki10-31k
model=${2-etm} # etm, etm_dirichlet, etm_dirichlet_rsvi, prod_lda, nb_vae, dvae, dvae_rsvi
run_ntms_mayank(){
  PROJECT="/scratch/$USER/thesis/tms/atlas/baselines/neural-topic-models/"
  # shellcheck disable=SC2164
  cd "$PROJECT"
  python main.py \
    --data_name 20ng \
    --model_name ${1-etm} \
    --max_epochs 50
}
run_cluster_analysis(){
    PROJECT="/scratch/$USER/thesis/tms/atlas/baselines/Cluster-Analysis/"
    # shellcheck disable=SC2164
    cd "$PROJECT"
    python
}
run_ntms_mayank prod_lda
conda deactivate 
