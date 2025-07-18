#!/bin/bash
#FLUX: --job-name=cpu1
#FLUX: -n=32
#FLUX: --queue=thin
#FLUX: -t=21600
#FLUX: --urgency=16

module load 2021
module load Python/3.9.5-GCCcore-10.3.0
cd ./NLI-experiments
pip3 install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cpu
pip install -r requirements.txt
pip uninstall -y codecarbon
python -m spacy download en_core_web_lg
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "sentiment-news-econ" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "sentiment-news-econ" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "coronanet" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "coronanet" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "cap-sotu" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "cap-sotu" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "cap-us-court" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "cap-us-court" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-8" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-8" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-military" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-military" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-morality" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-morality" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-protectionism" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-protectionism" --sample_interval 100 500 1000 --method "classical_ml" --model "logistic" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "sentiment-news-econ" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "sentiment-news-econ" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "coronanet" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "coronanet" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "cap-sotu" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "cap-sotu" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "cap-us-court" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "cap-us-court" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-8" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-8" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-military" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-military" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-morality" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-morality" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
python analysis-classical-hyperparams.py --n_trials 60 --n_trials_sampling 30 --n_trials_pruning 40 --n_cross_val_hyperparam 2 --context --dataset "manifesto-protectionism" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --hyperparam_study_date 20221006 --vectorizer "tfidf"
python analysis-classical-run.py --dataset "manifesto-protectionism" --sample_interval 100 500 1000 --method "classical_ml" --model "SVM" --n_cross_val_final 3 --hyperparam_study_date 20221006 --vectorizer "tfidf" --zeroshot
