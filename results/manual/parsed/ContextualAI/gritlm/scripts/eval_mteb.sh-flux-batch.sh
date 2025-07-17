#!/bin/bash
#FLUX: --job-name=mteb
#FLUX: --exclusive
#FLUX: --queue=a3
#FLUX: -t=356400
#FLUX: --urgency=16

export WANDB_PROJECT='gritlm'

cd /home/niklas/gritlm
source /env/bin/start-ctx-user
conda activate gritlmt2
export WANDB_PROJECT="gritlm"
ALLDS=(
AmazonCounterfactualClassification
AmazonPolarityClassification
AmazonReviewsClassification
ArguAna
ArxivClusteringP2P
ArxivClusteringS2S
AskUbuntuDupQuestions
BIOSSES
Banking77Classification
BiorxivClusteringP2P
BiorxivClusteringS2S
CQADupstackAndroidRetrieval
CQADupstackEnglishRetrieval
CQADupstackGamingRetrieval
CQADupstackGisRetrieval
CQADupstackMathematicaRetrieval
CQADupstackPhysicsRetrieval
CQADupstackProgrammersRetrieval
CQADupstackStatsRetrieval
CQADupstackTexRetrieval
CQADupstackUnixRetrieval
CQADupstackWebmastersRetrieval
CQADupstackWordpressRetrieval
ClimateFEVER
DBPedia
EmotionClassification
FEVER
FiQA2018
HotpotQA
ImdbClassification
MSMARCO
MTOPDomainClassification
MTOPIntentClassification
MassiveIntentClassification
MassiveScenarioClassification
MedrxivClusteringP2P
MedrxivClusteringS2S
MindSmallReranking
NFCorpus
NQ
QuoraRetrieval
RedditClustering
RedditClusteringP2P
SCIDOCS
SICK-R
STS12
STS13
STS14
STS15
STS16
STS17
STS22
STSBenchmark
SciDocsRR
SciFact
SprintDuplicateQuestions
StackExchangeClustering
StackExchangeClusteringP2P
StackOverflowDupQuestions
SummEval
TRECCOVID
Touche2020
ToxicConversationsClassification
TweetSentimentExtractionClassification
TwentyNewsgroupsClustering
TwitterSemEval2015
TwitterURLCorpus
)
FEWSHOT=(
Banking77Classification
EmotionClassification
ImdbClassification
BiorxivClusteringS2S
SprintDuplicateQuestions
TwitterSemEval2015
TwitterURLCorpus
AskUbuntuDupQuestions
ArguAna
SCIDOCS
STS12
SummEval
)
DS=${ALLDS[$SLURM_ARRAY_TASK_ID]}
echo "Running $DS"
python evaluation/eval_mteb.py \
--model_name_or_path /data/niklas/gritlm/m8x7_nodes32_400_fast \
--instruction_set e5 \
--instruction_format gritlm \
--task_names $DS \
--batch_size 64 \
--pipeline_parallel \
--attn_implementation sdpa \
--pooling_method mean
python evaluation/eval_mteb.py \
--model_name_or_path /data/niklas/gritlm/m8x7_nodes32_400_fast \
--instruction_set e5 \
--instruction_format gritlm \
--task_names $DS \
--batch_size 32 \
--pipeline_parallel \
--attn_implementation sdpa \
--pooling_method mean
python evaluation/eval_mteb.py \
--model_name_or_path /data/niklas/gritlm/m8x7_nodes32_400_fast \
--instruction_set e5 \
--instruction_format gritlm \
--task_names $DS \
--batch_size 16 \
--pipeline_parallel \
--attn_implementation sdpa \
--pooling_method mean
python evaluation/eval_mteb.py \
--model_name_or_path /data/niklas/gritlm/m8x7_nodes32_400_fast \
--instruction_set e5 \
--instruction_format gritlm \
--task_names $DS \
--batch_size 8 \
--pipeline_parallel \
--attn_implementation sdpa \
--pooling_method mean
python evaluation/eval_mteb.py \
--model_name_or_path /data/niklas/gritlm/m8x7_nodes32_400_fast \
--instruction_set e5 \
--instruction_format gritlm \
--task_names $DS \
--batch_size 4 \
--pipeline_parallel \
--attn_implementation sdpa \
--pooling_method mean
python evaluation/eval_mteb.py \
--model_name_or_path /data/niklas/gritlm/m8x7_nodes32_400_fast \
--instruction_set e5 \
--instruction_format gritlm \
--task_names $DS \
--batch_size 2 \
--pipeline_parallel \
--attn_implementation sdpa \
--pooling_method mean
