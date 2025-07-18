#!/bin/bash
#FLUX: --job-name=data-proc
#FLUX: -c=8
#FLUX: --queue=gpu-a40
#FLUX: -t=17940
#FLUX: --urgency=16

cat $0
echo "--------------------"
source ~/.bashrc
conda activate ckl
python run.py --config configs/templama/training/t5_baseline_debug.json
--------------------
/mmfs1/gscratch/ark/tjung2/miniconda3/envs/ckl/lib/python3.8/site-packages/pytorch_lightning/callbacks/model_checkpoint.py:396: LightningDeprecationWarning: Argument `period` in `ModelCheckpoint` is deprecated in v1.3 and will be removed in v1.5. Please use `every_n_val_epochs` instead.
  rank_zero_deprecation(
GPU available: True, used: True
TPU available: False, using: 0 TPU cores
initializing ddp: GLOBAL_RANK: 0, MEMBER: 1/1
----------------------------------------------------------------------------------------------------
distributed_backend=nccl
All DDP processes registered. Starting ddp with 1 processes
----------------------------------------------------------------------------------------------------
LOCAL_RANK: 0 - CUDA_VISIBLE_DEVICES: [0]
wandb: Currently logged in as: tjung2. Use `wandb login --relogin` to force relogin
Not freezing any parameters!
split is 0
Length of dataset retrieving is.. 49
wandb: wandb version 0.13.1 is available!  To upgrade, please run:
wandb:  $ pip install wandb --upgrade
wandb: Tracking run with wandb version 0.12.21
wandb: Run data is saved locally in /mmfs1/gscratch/ark/tjung2/continual-knowledge-learning/wandb/run-20220811_032007-2urqpqgq
wandb: Run `wandb offline` to turn off syncing.
wandb: Syncing run T5_small_templama(2010)_lr.001_baseline
wandb: ⭐️ View project at https://wandb.ai/tjung2/continual_learning_3
wandb: 🚀 View run at https://wandb.ai/tjung2/continual_learning_3/runs/2urqpqgq
Set SLURM handle signals.
  | Name  | Type                       | Params
-----------------------------------------------------
0 | model | T5ForConditionalGeneration | 77.0 M
-----------------------------------------------------
77.0 M    Trainable params
0         Non-trainable params
77.0 M    Total params
307.845   Total estimated model params size (MB)
Validation sanity check: 0it [00:00, ?it/s]split is 0
Length of dataset retrieving is.. 410
Validation sanity check:   0% 0/2 [00:00<?, ?it/s]
Validation sanity check:  50% 1/2 [00:00<00:00,  1.54it/s][["St. Mary's College", 'National Assembly of Pakistan', 'Ssei', 'House of Representatives of Japan', 'Notre Dame'], ['Copenhagen City Council', 'MEP', 'JS Kabylie', 'Yvonne', 'NBC']]
split is 0
Length of dataset retrieving is.. 49
Training: 0it [00:00, ?it/s]
Training:   0% 0/91 [00:00<?, ?it/s]
Epoch 0:   0% 0/91 [00:00<?, ?it/s] 
Epoch 0:   1% 1/91 [00:00<00:41,  2.16it/s]
Epoch 0:   1% 1/91 [00:00<00:41,  2.16it/s, loss=nan, v_num=pqgq]
Epoch 0:   2% 2/91 [00:00<00:23,  3.87it/s, loss=nan, v_num=pqgq][W reducer.cpp:1158] Warning: find_unused_parameters=True was specified in DDP constructor, but did not find any unused parameters in the forward pass. This flag results in an extra traversal of the autograd graph every iteration,  which can adversely affect performance. If your model indeed never has any unused parameters in the forward pass, consider turning this flag off. Note that this warning may be a false positive if your model has flow control causing later iterations to have unused parameters. (function operator())
Epoch 0:   3% 3/91 [00:00<00:18,  4.73it/s, loss=nan, v_num=pqgq]
Epoch 0:   3% 3/91 [00:00<00:18,  4.73it/s, loss=7.39, v_num=pqgq]
Epoch 0:   4% 4/91 [00:00<00:14,  5.87it/s, loss=7.39, v_num=pqgq]
Epoch 0:   5% 5/91 [00:00<00:12,  6.87it/s, loss=7.39, v_num=pqgq]
Epoch 0:   7% 6/91 [00:00<00:11,  7.26it/s, loss=7.39, v_num=pqgq]
Epoch 0:   7% 6/91 [00:00<00:11,  7.26it/s, loss=6.98, v_num=pqgq]
Epoch 0:   8% 7/91 [00:00<00:10,  7.99it/s, loss=6.98, v_num=pqgq]
Epoch 0:   9% 8/91 [00:00<00:09,  8.68it/s, loss=6.98, v_num=pqgq]
Epoch 0:  10% 9/91 [00:01<00:09,  8.37it/s, loss=6.98, v_num=pqgq]
Epoch 0:  10% 9/91 [00:01<00:09,  8.37it/s, loss=7.12, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:40,  2.01it/s][A
Epoch 0:  13% 12/91 [00:01<00:10,  7.26it/s, loss=7.12, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:15,  4.98it/s][A
Validating:   5% 4/82 [00:00<00:12,  6.00it/s][A
Epoch 0:  16% 15/91 [00:01<00:09,  7.70it/s, loss=7.12, v_num=pqgq]
Validating:   7% 6/82 [00:01<00:10,  7.28it/s][A
Validating:  10% 8/82 [00:01<00:08,  8.44it/s][A
Epoch 0:  20% 18/91 [00:02<00:09,  7.92it/s, loss=7.12, v_num=pqgq]
Validating:  12% 10/82 [00:01<00:07,  9.06it/s][A
Validating:  13% 11/82 [00:01<00:07,  9.06it/s][A
Epoch 0:  23% 21/91 [00:02<00:08,  8.15it/s, loss=7.12, v_num=pqgq]
Validating:  16% 13/82 [00:01<00:07,  9.16it/s][A
Epoch 0:  26% 24/91 [00:02<00:08,  8.31it/s, loss=7.12, v_num=pqgq]
Validating:  18% 15/82 [00:01<00:07,  8.88it/s][A
Validating:  21% 17/82 [00:02<00:06,  9.76it/s][A
Epoch 0:  30% 27/91 [00:03<00:07,  8.46it/s, loss=7.12, v_num=pqgq]
Validating:  23% 19/82 [00:02<00:06,  9.66it/s][A
Epoch 0:  33% 30/91 [00:03<00:07,  8.64it/s, loss=7.12, v_num=pqgq]
Validating:  26% 21/82 [00:02<00:05, 10.46it/s][A
Validating:  28% 23/82 [00:02<00:05, 10.50it/s][A
Epoch 0:  36% 33/91 [00:03<00:06,  8.80it/s, loss=7.12, v_num=pqgq]
Validating:  30% 25/82 [00:02<00:05, 10.40it/s][A
Epoch 0:  40% 36/91 [00:04<00:06,  8.87it/s, loss=7.12, v_num=pqgq]
Validating:  33% 27/82 [00:03<00:05, 10.01it/s][A
Validating:  35% 29/82 [00:03<00:05,  9.89it/s][A
Epoch 0:  43% 39/91 [00:04<00:05,  8.92it/s, loss=7.12, v_num=pqgq]
Validating:  38% 31/82 [00:03<00:04, 10.67it/s][A
Epoch 0:  46% 42/91 [00:04<00:05,  9.02it/s, loss=7.12, v_num=pqgq]
Validating:  40% 33/82 [00:03<00:04, 10.50it/s][A
Validating:  43% 35/82 [00:03<00:04,  9.43it/s][A
Epoch 0:  49% 45/91 [00:04<00:05,  9.03it/s, loss=7.12, v_num=pqgq]
Validating:  44% 36/82 [00:04<00:04,  9.24it/s][A
Validating:  45% 37/82 [00:04<00:04,  9.03it/s][A
Validating:  46% 38/82 [00:04<00:04,  9.03it/s][A
Epoch 0:  53% 48/91 [00:05<00:04,  9.00it/s, loss=7.12, v_num=pqgq]
Validating:  49% 40/82 [00:04<00:04,  9.49it/s][A
Validating:  50% 41/82 [00:04<00:04,  9.04it/s][A
Epoch 0:  56% 51/91 [00:05<00:04,  9.01it/s, loss=7.12, v_num=pqgq]
Validating:  52% 43/82 [00:04<00:04,  9.61it/s][A
Epoch 0:  59% 54/91 [00:05<00:04,  9.09it/s, loss=7.12, v_num=pqgq]
Validating:  55% 45/82 [00:05<00:04,  8.83it/s][A
Validating:  57% 47/82 [00:05<00:03,  9.73it/s][A
Epoch 0:  63% 57/91 [00:06<00:03,  9.09it/s, loss=7.12, v_num=pqgq]
Validating:  59% 48/82 [00:05<00:03,  9.60it/s][A
Validating:  60% 49/82 [00:05<00:03,  9.09it/s][A
Epoch 0:  66% 60/91 [00:06<00:03,  9.12it/s, loss=7.12, v_num=pqgq]
Validating:  62% 51/82 [00:05<00:03,  9.43it/s][A
Validating:  65% 53/82 [00:05<00:02, 10.01it/s][A
Epoch 0:  69% 63/91 [00:06<00:03,  9.15it/s, loss=7.12, v_num=pqgq]
Validating:  66% 54/82 [00:06<00:03,  7.87it/s][A
Validating:  68% 56/82 [00:06<00:02,  9.02it/s][A
Epoch 0:  73% 66/91 [00:07<00:02,  9.06it/s, loss=7.12, v_num=pqgq]
Validating:  70% 57/82 [00:06<00:02,  8.99it/s][A
Validating:  72% 59/82 [00:06<00:02,  9.95it/s][A
Epoch 0:  76% 69/91 [00:07<00:02,  9.12it/s, loss=7.12, v_num=pqgq]
Validating:  74% 61/82 [00:06<00:02, 10.42it/s][A
Epoch 0:  79% 72/91 [00:07<00:02,  9.20it/s, loss=7.12, v_num=pqgq]
Validating:  77% 63/82 [00:06<00:01, 10.71it/s][A
Validating:  79% 65/82 [00:07<00:01, 10.50it/s][A
Epoch 0:  82% 75/91 [00:08<00:01,  9.24it/s, loss=7.12, v_num=pqgq]
Validating:  82% 67/82 [00:07<00:01, 10.94it/s][A
Epoch 0:  86% 78/91 [00:08<00:01,  9.34it/s, loss=7.12, v_num=pqgq]
Validating:  84% 69/82 [00:07<00:01, 11.47it/s][A
Validating:  87% 71/82 [00:07<00:00, 11.64it/s][A
Epoch 0:  89% 81/91 [00:08<00:01,  9.42it/s, loss=7.12, v_num=pqgq]
Validating:  89% 73/82 [00:07<00:00, 10.96it/s][A
Epoch 0:  92% 84/91 [00:08<00:00,  9.38it/s, loss=7.12, v_num=pqgq]
Validating:  91% 75/82 [00:07<00:00,  9.70it/s][A
Validating:  94% 77/82 [00:08<00:00, 10.32it/s][A
Epoch 0:  96% 87/91 [00:09<00:00,  9.42it/s, loss=7.12, v_num=pqgq]
Validating:  96% 79/82 [00:08<00:00,  9.92it/s][A
Epoch 0:  99% 90/91 [00:09<00:00,  9.41it/s, loss=7.12, v_num=pqgq]
Validating:  99% 81/82 [00:08<00:00, 10.34it/s][A[["St. John's College", 'Knesset', 'Ssei', 'House of Representatives of Japan', 'École Polytechnique'], ['Copenhagen City Council', 'MEP', 'JS Kabylie', 'Yvonne', 'NBC'], ['Rothschild', 'Marta Lewicka', 'Büyükşehir Bey', 'Sergei', 'FC Barcelona'], ['Hans-Joachim', 'Registrar of Social Security', 'Parliament of Finland', 'MEP', 'National Academy of Sciences'], ['NBC Universal', 'Eurostar', 'Sr.', 'Leicester Tigers', "St. John's"], ['scar lvarez', 'Saint-Sauveur-sur-Mer', 'NBC News', 'BBC Worldwide', 'Max Planck Society'], ['England', 'eljko', 'England', 'National Assembly of Pakistan', 'Ynglings'], ['NBC News', "St. John's University", 'NBC News', 'NBC', 'Darren'], ['Ford Motor Company', 'Miss Philippines Earth', 'Michael', 'Universidad de Chile', 'ONGC'], ['IFK Göteborg', 'Qi Lu', 'Ched Evans', 'Sergei', 'Wells Fargo'], ['Justice of the Peace', 'David A. McKinley', 'MEP', 'CPC', 'Sveriges Riksbank'], ['England', 'UNESCO', 'Galliano', 'Universidad de Chile', 'North Carolina State University'], ['Sony Pictures', 'Democratic Party', 'Olimpia Roma', 'FK Radniki Ni', 'FC Utrecht'], ['Max Hollein', 'Pennsylvania General Assembly', 'John', 'Jeremy', 'Luca Giordano'], ['Malaysian Academy of Sciences', 'Real Madrid', 'YB Raj Khatiwada', 'Netscape', 'Ajax'], ['ZANU-PF', 'MEP', 'Sony Pictures', 'EMI', 'Al-Ahly'], ['Team GB', 'SV Werder Bremen', 'RC Lens', 'National Assembly of France', 'David'], ['MEP', 'Justice of the Peace', 'Tadeusz Kocielny', 'Hapoel Tel Aviv', 'Silvio Berlusconi'], ['National Assembly of Romania', 'National Assembly of France', 'IFSC', 'Justice of the Peace', 'Italian Academy of Sciences'], ['Kimbrough County', 'National Assembly of Serbia', 'Belinda', 'Granada Television', 'New York Cosmos'], ['Chartered Accountant', 'Xiamen University', 'Fratelli', 'Team USA', 'Vtková'], ['Associated Press', 'eljko', 'José Luis Rodrguez', 'Sveriges Riksbank', 'Turin City Council'], ['New Zealand', 'FC Twente', 'NBC', 'NBC News', 'sterreichische Galerie'], ['Y Combinator', 'eljko', 'Grupo Panamericano', 'Srensen', 'Team Ghana'], ['Italian Academy of Sciences', 'UNESCO', 'Italian Academy of Sciences', 'Xenophon', 'Univision'], ['QC', 'Connacht', 'lvaro Pérez', 'Norwegian Academy of Science and Letters', 'HC Spartak Moscow'], ['Y Combinator', 'Sr.', 'England', 'EMI Finland', 'Svendsen'], ['NBC', 'SourceForge Inc', "People's Artist", 'The Rabbit Foundation', 'NBCUniversal'], ['NBC News', 'tefan', 'EMI', 'Sergei Mikhailovich Ivanov', 'Team GB'], ['Kyto', 'FC Seoul', 'Team Canada', 'Universidad de Chile', 'Sr.'], ['CSKA Moscow', 'RC Lens', 'NBC', 'CPI', 'NBC'], ['National Assembly of Spain', 'Batangas City Council', 'Petrobras', 'International Federation of Associations of Swiss Architects', 'National Assembly of France'], ['Wisconsin State Assembly', 'EMI', 'Northamptonshire', 'Yuriy', 'NBC'], ['M.I.A.', 'Democrat', 'Göttingen', 'Team USA', 'lvaro'], ['Maccabi Tel Aviv', 'Sergei', 'François-Joseph Lefebvre', 'National Assembly of Romania', 'University of the West Indies'], ['Democrat', 'David', 'MEP', 'Russian Academy of Sciences', 'Paulista de So Paulo'], ['Paulista de So Paulo', 'Democratic Party of Korea', 'National Assembly of Thailand', 'Northamptonshire', 'Hart Blanton'], ['Rand Museum', 'House of Representatives of the Philippines', 'Combined Universities', 'Esteghlal', 'Kongregate Group'], ['FC Barcelona', 'The New York Times', 'NBC News', 'Kre Schultz', 'Eurosport Group'], ['Democrat', 'Italian Academy of Sciences', 'Qatari', 'efovi', 'Sr.'], ['NBC News', 'Wisconsin State Assembly', 'National Assembly of Romania', 'Australian Senate', 'Joo José dos Santos'], ['England', 'Clemente Clemente', 'National Assembly of France', 'Liaoning City Council', 'LA Weekly'], ['Xie', 'European Parliament', 'Australia', 'Sporting Clube de Portugal', 'National Security Advisor'], ['Sony Pictures', 'MEP', 'Registrar of Societies', 'Al-Ahly', 'National Assembly of Romania'], ['NBC News', 'Y Combinator', 'Vytautas ivkovs', 'European Parliament', 'Sr.'], ['Changhua County Executive', 'Sinclair Broadcast Group', 'David A. Smith', 'Team GB', 'NBC News'], ['NBCUniversal', 'Mike', 'NBC', 'NBC News', 'NBC'], ['Waseda University', 'Nordic Council of Ministers', 'MEP', 'Yves Leclerc', 'European Parliament'], ['University of Oyo', 'National Assembly of Pakistan', 'Marcin ukasiewicz', 'Sr.', "St. Patrick's"], ['Miss Philippines Earth', 'Viva Records', 'XI Punjab', 'Sr.', 'Democrat'], ["St. Patrick's", 'algiris Kalev', 'Jean-Baptiste Lefèvre', 'Registrar of Companies', 'Registrar of Societies'], ['National Assembly of Lithuania', 'Cardiff Blues', 'NBC', 'Sr.', 'Registrar of the Republic'], ['MEP', 'FC Barcelona B', 'Lithuanian National Assembly', 'Team USA', 'Granada'], ["comte de l'Ordre des Arts et des Lettres", 'NBC News', 'ONGC', 'Indian National Congress', 'NBC'], ['Bergen Metro', 'ICICI Bank', 'Editura Ionescu', 'Secretary of the Treasury', 'Sr.'], ['Justice of the Peace', 'EMI', 'Hawaii State Executive Council', 'Sony Pictures Television', 'The New York Times'], ['Heinz-Heinz', 'Minnesota House of Representatives', 'RC Lens', 'lvaro de la Cruz', 'Armenian Artists'], ['New England Patriots', 'Chamber of Deputies', 'Italian Senate', 'Team GB', "St. John's University"], ['Democrat', 'Olimpia', 'National Academy of Sciences', 'CBE', 'National Assembly of France'], ['Romanian Academy', 'MEP', 'NBC', 'Sporting Clube de Portugal', 'National Security Advisor'], ['House of Representatives of Japan', 'Microsoft', 'Président de la République', 'National Assembly of Pakistan', 'Serie B'], ['European Parliament', 'FC Honolulu', 'Seoul National University', 'Italian Academy of Sciences', 'Hermann Müller'], ['Hermann Göring', 'Republican Party', 'National Assembly of France', 'The Bullards', 'Esteghlal'], ['Energia', 'Team USA', 'Yvonne', 'Yenisei', "St. Mary's College"], ['Syed Ali Khan', 'The New York Times', 'Hickory Newspapers, Inc', 'National Assembly of Italy', 'The New York Times'], ["St. John's College", 'Scotland', 'National Assembly of Pakistan', 'Helmut Schmidt', "O'Brien"], ['National Assembly of Romania', 'jpest', 'Westfield Wheaton Corporation', 'NBC News', 'Milan City Council'], ['FC Barcelona', 'New Zealand', 'Miss America', 'Federal Building Development Corporation', 'Romanian National Hero'], ['Sony Pictures', 'UNESCO', 'NBC', 'lvaro', 'Azerbaijan State University'], ['David', 'Philippe de Bourges', 'Volkswagen Group', 'Jean-Pierre Lefèvre', 'National Assembly of China'], ['Universidad de Chile', 'Sr.', 'Harvard University', 'Boxer TV LLC', 'Charlotte Hornets LLC'], ['FC Barcelona', 'Chennai Super Kings', 'Universidad de Chile', 'Giuseppe Garibaldi', "Michael J. O'Connor"], ['National Assembly of France', 'NBCUniversal', 'Taoiseach', 'CSKA Moscow', 'NBC Universal'], ['FC Olimpia', 'Cork City', 'Mike McCoy', 'Pakistan Muslim League', 'st nad Labem'], ['CPI', 'KS ód', "St. John's College", 'NBC Sports', 'NBC Universal'], ['Universidad de Chile', 'Rhys Jones', 'Team USA', "St. Mary's", 'Boise City Council'], ['Wishnutama', 'NBC News', 'Giuseppe', 'European Parliament', 'National Assembly of Serbia'], ['Ferrari', 'FC Barcelona B', "Musée d'Art Moderne", 'Ferrari', 'FC Barcelona'], ['Sacred Heart Academy', 'NBC Sports', 'Regierungspräsident', 'Sveriges Riksbank', 'FC Utrecht'], ['Sr.', 'Sr-Trm', 'Sr.', 'National Assembly of France', 'Pau'], ['Delhi Dynamos', 'EMI', 'PEN', 'Team GB', 'Justice of Appeal'], ['Sahrawi Arab Democratic Republic', 'Australian Senate', 'NBC News', 'Auckland Council', 'Pandolfi']]
Epoch 0: 100% 91/91 [00:09<00:00,  9.30it/s, loss=7.12, v_num=pqgq]
                                               [A
Epoch 0:   0% 0/91 [00:00<?, ?it/s, loss=7.12, v_num=pqgq]         
Epoch 1:   0% 0/91 [00:00<?, ?it/s, loss=7.12, v_num=pqgq]
Epoch 1:   1% 1/91 [00:00<00:39,  2.26it/s, loss=7.12, v_num=pqgq]
Epoch 1:   2% 2/91 [00:00<00:21,  4.05it/s, loss=7.12, v_num=pqgq]
Epoch 1:   3% 3/91 [00:00<00:17,  5.06it/s, loss=7.12, v_num=pqgq]
Epoch 1:   3% 3/91 [00:00<00:17,  5.05it/s, loss=7.04, v_num=pqgq]
Epoch 1:   4% 4/91 [00:00<00:13,  6.24it/s, loss=7.04, v_num=pqgq]
Epoch 1:   5% 5/91 [00:00<00:11,  7.28it/s, loss=7.04, v_num=pqgq]
Epoch 1:   7% 6/91 [00:00<00:11,  7.54it/s, loss=7.04, v_num=pqgq]
Epoch 1:   7% 6/91 [00:00<00:11,  7.54it/s, loss=6.93, v_num=pqgq]
Epoch 1:   8% 7/91 [00:00<00:10,  8.29it/s, loss=6.93, v_num=pqgq]
Epoch 1:   9% 8/91 [00:00<00:09,  8.98it/s, loss=6.93, v_num=pqgq]
Epoch 1:  10% 9/91 [00:01<00:09,  8.60it/s, loss=6.93, v_num=pqgq]
Epoch 1:  10% 9/91 [00:01<00:09,  8.60it/s, loss=6.79, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:41,  1.95it/s][A
Epoch 1:  13% 12/91 [00:01<00:10,  7.25it/s, loss=6.79, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:17,  4.43it/s][A
Validating:   6% 5/82 [00:00<00:11,  6.58it/s][A
Epoch 1:  16% 15/91 [00:01<00:10,  7.58it/s, loss=6.79, v_num=pqgq]
Validating:   7% 6/82 [00:01<00:10,  7.11it/s][A
Validating:   9% 7/82 [00:01<00:11,  6.64it/s][A
Epoch 1:  20% 18/91 [00:02<00:09,  7.72it/s, loss=6.79, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:08,  8.36it/s][A
Validating:  12% 10/82 [00:01<00:08,  8.31it/s][A
Validating:  13% 11/82 [00:01<00:08,  8.32it/s][A
Epoch 1:  23% 21/91 [00:02<00:08,  7.87it/s, loss=6.79, v_num=pqgq]
Validating:  16% 13/82 [00:01<00:08,  7.92it/s][A
Validating:  17% 14/82 [00:02<00:09,  7.41it/s][A
Epoch 1:  26% 24/91 [00:03<00:08,  7.73it/s, loss=6.79, v_num=pqgq]
Validating:  20% 16/82 [00:02<00:07,  8.66it/s][A
Validating:  21% 17/82 [00:02<00:08,  8.08it/s][A
Epoch 1:  30% 27/91 [00:03<00:08,  7.88it/s, loss=6.79, v_num=pqgq]
Validating:  22% 18/82 [00:02<00:08,  7.79it/s][A
Validating:  24% 20/82 [00:02<00:06,  9.11it/s][A
Epoch 1:  33% 30/91 [00:03<00:07,  8.03it/s, loss=6.79, v_num=pqgq]
Validating:  26% 21/82 [00:02<00:07,  8.24it/s][A
Validating:  27% 22/82 [00:02<00:07,  7.88it/s][A
Validating:  28% 23/82 [00:03<00:08,  7.32it/s][A
Epoch 1:  36% 33/91 [00:04<00:07,  7.85it/s, loss=6.79, v_num=pqgq]
Validating:  29% 24/82 [00:03<00:07,  7.42it/s][A
Validating:  32% 26/82 [00:03<00:07,  7.75it/s][A
Epoch 1:  40% 36/91 [00:04<00:06,  7.86it/s, loss=6.79, v_num=pqgq]
Validating:  33% 27/82 [00:03<00:07,  7.76it/s][A
Validating:  35% 29/82 [00:03<00:06,  7.97it/s][A
Epoch 1:  43% 39/91 [00:04<00:06,  7.88it/s, loss=6.79, v_num=pqgq]
Validating:  38% 31/82 [00:04<00:05,  8.94it/s][A
Validating:  39% 32/82 [00:04<00:06,  8.08it/s][A
Epoch 1:  46% 42/91 [00:05<00:06,  7.93it/s, loss=6.79, v_num=pqgq]
Validating:  40% 33/82 [00:04<00:06,  8.12it/s][A
Validating:  41% 34/82 [00:04<00:05,  8.04it/s][A
Validating:  43% 35/82 [00:04<00:06,  7.74it/s][A
Epoch 1:  49% 45/91 [00:05<00:05,  7.92it/s, loss=6.79, v_num=pqgq]
Validating:  44% 36/82 [00:04<00:06,  7.57it/s][A
Validating:  45% 37/82 [00:04<00:06,  7.44it/s][A
Epoch 1:  53% 48/91 [00:06<00:05,  7.91it/s, loss=6.79, v_num=pqgq]
Validating:  48% 39/82 [00:05<00:05,  8.46it/s][A
Validating:  49% 40/82 [00:05<00:05,  7.98it/s][A
Validating:  50% 41/82 [00:05<00:05,  7.95it/s][A
Epoch 1:  56% 51/91 [00:06<00:05,  7.92it/s, loss=6.79, v_num=pqgq]
Validating:  51% 42/82 [00:05<00:05,  7.95it/s][A
Validating:  54% 44/82 [00:05<00:04,  8.32it/s][A
Epoch 1:  59% 54/91 [00:06<00:04,  7.96it/s, loss=6.79, v_num=pqgq]
Validating:  55% 45/82 [00:05<00:04,  7.55it/s][A
Validating:  56% 46/82 [00:06<00:04,  7.55it/s][A
Epoch 1:  63% 57/91 [00:07<00:04,  7.93it/s, loss=6.79, v_num=pqgq]
Validating:  59% 48/82 [00:06<00:04,  8.46it/s][A
Validating:  60% 49/82 [00:06<00:04,  7.95it/s][A
Epoch 1:  66% 60/91 [00:07<00:03,  7.97it/s, loss=6.79, v_num=pqgq]
Validating:  62% 51/82 [00:06<00:03,  8.83it/s][A
Validating:  65% 53/82 [00:06<00:03,  9.59it/s][A
Epoch 1:  69% 63/91 [00:07<00:03,  8.07it/s, loss=6.79, v_num=pqgq]
Validating:  67% 55/82 [00:06<00:02,  9.57it/s][A
Validating:  68% 56/82 [00:07<00:02,  8.99it/s][A
Epoch 1:  73% 66/91 [00:08<00:03,  8.09it/s, loss=6.79, v_num=pqgq]
Validating:  70% 57/82 [00:07<00:02,  8.84it/s][A
Validating:  71% 58/82 [00:07<00:02,  8.53it/s][A
Epoch 1:  76% 69/91 [00:08<00:02,  8.13it/s, loss=6.79, v_num=pqgq]
Validating:  73% 60/82 [00:07<00:02,  9.53it/s][A
Validating:  74% 61/82 [00:07<00:02,  9.24it/s][A
Validating:  76% 62/82 [00:07<00:02,  8.78it/s][A
Epoch 1:  79% 72/91 [00:08<00:02,  8.15it/s, loss=6.79, v_num=pqgq]
Validating:  77% 63/82 [00:07<00:02,  8.88it/s][A
Validating:  78% 64/82 [00:08<00:02,  8.45it/s][A
Epoch 1:  82% 75/91 [00:09<00:01,  8.18it/s, loss=6.79, v_num=pqgq]
Validating:  80% 66/82 [00:08<00:01,  9.31it/s][A
Validating:  82% 67/82 [00:08<00:01,  8.31it/s][A
Validating:  83% 68/82 [00:08<00:01,  8.16it/s][A
Epoch 1:  86% 78/91 [00:09<00:01,  8.17it/s, loss=6.79, v_num=pqgq]
Validating:  84% 69/82 [00:08<00:01,  8.04it/s][A
Validating:  85% 70/82 [00:08<00:01,  7.39it/s][A
Epoch 1:  89% 81/91 [00:09<00:01,  8.16it/s, loss=6.79, v_num=pqgq]
Validating:  88% 72/82 [00:08<00:01,  8.56it/s][A
Validating:  89% 73/82 [00:09<00:01,  8.56it/s][A
Validating:  90% 74/82 [00:09<00:01,  7.64it/s][A
Epoch 1:  92% 84/91 [00:10<00:00,  8.14it/s, loss=6.79, v_num=pqgq]
Validating:  91% 75/82 [00:09<00:00,  8.01it/s][A
Validating:  94% 77/82 [00:09<00:00,  8.22it/s][A
Epoch 1:  96% 87/91 [00:10<00:00,  8.16it/s, loss=6.79, v_num=pqgq]
Validating:  95% 78/82 [00:09<00:00,  7.94it/s][A
Validating:  96% 79/82 [00:09<00:00,  7.86it/s][A
Validating:  98% 80/82 [00:09<00:00,  8.17it/s][A
Epoch 1:  99% 90/91 [00:11<00:00,  8.15it/s, loss=6.79, v_num=pqgq]
Validating: 100% 82/82 [00:10<00:00,  7.85it/s][A[['University of the West Indies', 'Democratic Party', 'Yokohama Shimbun', 'Democratic Party', 'École Normale Supérieure'], ['Christian Frederiksen', 'MEP', 'JS Kabylie', 'Yashwantrao', 'NBC News'], ['Rothschild Group', 'Yves Saint Laurent', 'Recep Tayyip Erdogan', 'Sergei Ivanovich Kostyakov', 'FC Barcelona B'], ['Andreas Kühn', 'Democrat of Finland', 'Green Party of Finland', 'MEP', 'Democratic Party'], ['NBC Universal', 'Eurostar International Limited', 'Democrat', 'Accrington Stanley', 'University of Michigan'], ['Yves de la Gardie', 'Yves Saint Laurent', 'The New York Times', 'Granada Television', 'Wolfgang von Goethe'], ['Accrington Stanley', 'eljko orevi', 'SV Werder Bremen', 'National Assembly of Pakistan', 'Yves Saint Laurent'], ['NBC News', 'University of Southern California', 'NBC News', 'NBC News', 'Darren'], ['Ford', 'Miss Philippines Philippines', 'John C. McKinley', 'FC Barcelona B', 'ONGC FC'], ['IFK Göteborg', 'Xiao Xia', 'Ched Evans', 'Irina Yushchenko', 'Wells Fargo Center, Inc'], ['Justice of the Peace', 'Yuriy Yaroslavsky', 'Chancellor of the Exchequer', 'Democrat', 'MEP'], ['Darren Fletcher', 'UNESCO', 'Galliano & Galliano', 'FC Barcelona B', 'University of Miami'], ['NBC Universal', 'Democratic Party', 'Olimpia Milano', 'FK eljezniar Sarajevo', 'FC Utrecht'], ['Yves Saint Laurent-de-Ville', 'Pennsylvania General Assembly', 'John McKay', 'Yashwantrao', 'Maurizio Giacometti'], ['Malaysian National Assembly', 'FC Barcelona', 'UNESCO', 'Netscape', 'Ajax'], ['ZANU PF', 'MEP', 'NBC News', 'Y Combinator', 'Al-Ahly'], ['SK eljezniar', 'SV Werder Bremen', 'RC Strasbourg', 'National Assembly of France', 'Yvonne Yves'], ['Democrat', 'Justice of the Peace', 'Tadeusz Kociuszko', 'Hapoel Jerusalem', 'Giuseppe Giacomo Giacometti'], ['Romanian Academy of Sciences', 'National Assembly of France', 'Yuriy Yakovlev', 'AKP Member of Parliament', 'Italian Democratic Party'], ['Kimbrough University', 'Democratic Party of Serbia', 'NBC News', 'The New York Times', 'FC Barcelona B'], ['MEP', 'Xinjiang University', 'Fratelli Fabbri', 'FC Dallas', 'Vtzslav tpány'], ['The New York Times', "Jean-Pierre d'Alembert", 'lvaro Cárdenas', 'Sveriges Riksrat', 'Silvio Berlusconi'], ['FC St. Gallen', 'FC Wout Brama', 'NBC News', 'NBC News', 'Yves Saint Laurent-de-Ville'], ['Y Combinator', 'FC Universitatea Craiova', 'Grupo Panamericano', 'Sven-Göran Eriksson', 'FC Universitatea Craiova'], ['Democratic Party', 'UNESCO', 'Italian Democratic Party', 'MIT Media Lab', 'Unión Espaa'], ['MEP', 'Conor Murray', 'lvaro lvarez', 'Social Democratic Party of Norway', 'FC St. Petersburg'], ['4chan Group', 'MEP', 'Grasshoppers', 'Finland', 'lvaro Cáceres'], ['Xerox', 'SourceForge, Inc', 'CBE', 'The Kennel Club', 'NBCUniversal'], ['The New York Times', 'tefan Bălcescu', 'Y Combinator', 'Sergei Sergeyevich Ivanov', 'SK eljezniar'], ['Shigeru Ishii', 'SK Rapid Wien', 'CSKA Moscow', 'FC Barcelona B', 'United States Secretary of State'], ['FC St. Petersburg', 'RC Lens', 'NBC News', 'Democrat', 'The New York Times'], ['National Assembly of Spain', 'Gregorio Aguinaldo', 'Petronas', 'Argentine Association for the Advancement of Science', 'National Assembly of France'], ['Democratic Party', 'stgötland', 'SV Werder Bremen II', 'scar lvarez', 'NBC News'], ['Democrat', 'United States Attorney', 'Wolfgang von Karajan', 'FC Barcelona', 'Mauricio lvarez'], ['JS Kabylie', 'Sergey Ivanovich Kostyuk', 'Jean-Pierre Lefebvre', 'National Assembly of Romania', 'University of the West Indies'], ['Justice of the Peace', 'Graeme', 'Democrat', 'Russian Academy of Sciences', 'Antônio Carlos de Oliveira'], ['Antônio Carlos de Oliveira', 'Democratic Progressive Party', 'Sri Lanka Freedom Party', 'Accrington Stanley', 'NBC News'], ['Rand Art Museum', 'Democratic Party of Puerto Rico', 'R.A. Dickey', 'Al-Shorta', 'Kongregate Group'], ['FC Barcelona B', 'NBC News', 'NBC News', 'Kre Schultz', 'Eurosport Group'], ['Justice of the Peace', 'Italian Democratic Party', 'Abdullah bin Abdullah Al Thani', 'efovi', 'Justice of the Peace'], ['The New York Times', 'Democratic Party', 'Romanian National Assembly', 'National Assembly for Wales', 'Luiz José Lula da Silva'], ['FC Barcelona B', 'UNESCO', 'National Assembly of France', 'Liaoning City Council', 'LA Weekly'], ['Xu', 'National Assembly of Spain', 'FC St. Petersburg', 'FC Porto', ''], ['Xerox', 'M.C.', 'comte della Repubblica', 'Al-Ahly', 'National Assembly of Romania'], ['The New York Times', 'Y Combinator', 'eljko ivkovi', 'National Assembly of Romania', 'Justice of the Peace'], ['Liu Xiaoyuan', 'Nexstar Media Group, Inc', 'David A. Sullivan', 'Yokohama FC', 'The New York Times'], ['UNESCO', 'Mike McKay', 'NBC', 'NBC News', 'Yves Saint Laurent'], ['University of Tokyo', 'Social Democratic Party of Norway', 'MEP', 'Yves Saint Laurent', 'Democratic Party'], ['University of Lagos', 'Pakistan Peoples Party', 'Józef wicicki', 'Democrat', "St. Patrick's Athletic"], ['Registrar of Publications', 'Universidad de Chile', 'SK Rapid Wien', 'Democrat of the Year', 'Justice of the Peace'], ['FC St. Gallen', 'FC Barcelona B', 'Jean-Pierre Lefèvre', 'Democrat', 'Democrat of Finland'], ['Lithuanian National Assembly', 'Accrington Stanley', 'Lucas Richman', 'Democrat', 'Electoral Elect'], ['Electoral Elect', 'FC Olimpia Basel', 'Lithuanian Democratic Party', 'SV Werder Bremen', 'Y Combinator'], ['MEP', 'The New York Times', 'JS Kabylie', 'Indian National Congress', 'MIT Media Lab'], ['Bergen Metro', 'Amar Gupta', "Editura coala d'Arte", 'Carlos Alberto González Navarro', 'United States Attorney'], ['Justice of the Peace', 'Xerox', 'Kahn', 'Yenisey Kravchenko', 'UNESCO'], ['Markus Schreiber', 'Democratic Party', 'RC Lens', 'lvaro Aguilar', 'Armenian National Radio'], ['SK Rapid Wien', 'National Assembly of Brazil', 'Democratic Party', 'rnsköldsvik', "St. John's University"], ['Democrat of the Year', 'FC Barcelona B', 'National Assembly of Pakistan', 'Justice of the Peace', 'National Assembly of France'], ['Romanian National Assembly', 'MEP', 'NBC News', 'FC Porto', ''], ['Democratic Party', 'Y Combinator', "comte d'Orsay", 'Pakistan Peoples Party', 'Luca Becchio'], ['Italian Democratic Party', 'SK Rapid Wien', 'Seoul National University', 'Accensi Accensi', 'scar lvarez'], ['Maurizio Graziani', 'Republican Party', 'National Assembly of France', 'FC Barcelona B', 'Al-Ahli'], ['Energia', 'SK Rapid Wien', 'Yuriy Yakovlev', 'Yenisei Yeni', 'The Netherlands Academy of Arts and Sciences'], ['Syed Abdullah', 'The New York Times', 'Hickory Newspapers LLC', 'Democratic Party', 'NBC News'], ['University of Amsterdam', 'SK Rapid Wien', 'Islamic Republic of Iran Party', 'Gerhard Schröder', 'Sé'], ['National Assembly of Romania', 'University of Prague', 'Westfield Wheaton LLC', 'Yves Saint Laurent-de-Ville', 'Silvio Berlusconi'], ['FC Barcelona B', 'FC St. Gallen', 'Democrat of the Year', 'Federal Building Development Corporation', "Romanian People's Deputy of Romania"], ['Yoh Iwasa Productions', 'UNESCO', 'NBC News', 'lvaro lvarez', 'Azerbaijan University'], ['Yves de la Gardie', 'Jacques-Louis David', 'sterreichischer Rundfunk', 'François-Joseph Lafontaine', "People's Democratic Party"], ['FC Barcelona B', 'Justice of the Peace', 'Harvard University', 'Boxer TV LLC', 'Charlotte Hornets LLC'], ['FC Barcelona B', 'FC Dinamo Tbilisi', 'FC Barcelona B', 'Silvio Berlusconi', 'David A. Sullivan'], ['Social Democratic Party of Belgium', 'NBC News', 'Taoiseach', 'CSKA Moscow', 'NBC Universal'], ['FC Universitatea Craiova', 'rneath', 'Mike McCoy', 'Bangladesh Nationalist Party', 'eljko orevi'], ['CBE', 'KS ód', "St. John's College", 'Y Combinator', 'NBC Universal'], ['FC Barcelona', 'David Jones', 'FC St. Petersburg', 'Erin McLeod', 'John C. McKinley'], ['UNESCO', 'NBC News', 'Giuseppe Giacometti', 'Governing Council of the European Union', 'Serbian Progressive Party'], ['Ferrari Corporation', 'FC Universitatea Craiova', 'Yves Saint Laurent', 'Accademia di Belle Arti di Roma', 'FC Barcelona B'], ["St. Mary's College", 'NBC News', 'Hans-Joachim Schröder', 'Sveriges Riksrat', 'SV Werder Bremen'], ['Chancellor of the Peace', 'MEP', 'U.S. Attorney', 'National Assembly of France', 'Jean-Pierre Lefebvre'], ['CSKA Moscow', 'Y Combinator', 'PEN International', 'SK Rapid Wien', 'Justice of the Peace'], ['Ahmed Al-Mahdi Al-Sahrawi', 'Labour Party', 'The New York Times', "Peter O'Neill", 'FIAT Italy']]
Epoch 1: 100% 91/91 [00:11<00:00,  8.00it/s, loss=6.79, v_num=pqgq]
                                               [A
Epoch 1:   0% 0/91 [00:00<?, ?it/s, loss=6.79, v_num=pqgq]         
Epoch 2:   0% 0/91 [00:00<?, ?it/s, loss=6.79, v_num=pqgq]
Epoch 2:   1% 1/91 [00:00<00:41,  2.16it/s, loss=6.79, v_num=pqgq]
Epoch 2:   2% 2/91 [00:00<00:22,  3.90it/s, loss=6.79, v_num=pqgq]
Epoch 2:   3% 3/91 [00:00<00:18,  4.88it/s, loss=6.79, v_num=pqgq]
Epoch 2:   3% 3/91 [00:00<00:18,  4.87it/s, loss=6.63, v_num=pqgq]
Epoch 2:   4% 4/91 [00:00<00:14,  6.04it/s, loss=6.63, v_num=pqgq]
Epoch 2:   5% 5/91 [00:00<00:12,  7.06it/s, loss=6.63, v_num=pqgq]
Epoch 2:   7% 6/91 [00:00<00:11,  7.46it/s, loss=6.63, v_num=pqgq]
Epoch 2:   7% 6/91 [00:00<00:11,  7.46it/s, loss=6.43, v_num=pqgq]
Epoch 2:   8% 7/91 [00:00<00:10,  8.20it/s, loss=6.43, v_num=pqgq]
Epoch 2:   9% 8/91 [00:00<00:09,  8.90it/s, loss=6.43, v_num=pqgq]
Epoch 2:  10% 9/91 [00:01<00:09,  8.53it/s, loss=6.43, v_num=pqgq]
Epoch 2:  10% 9/91 [00:01<00:09,  8.53it/s, loss=6.21, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:39,  2.06it/s][A
Epoch 2:  13% 12/91 [00:01<00:10,  7.30it/s, loss=6.21, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:18,  4.35it/s][A
Validating:   5% 4/82 [00:00<00:15,  5.03it/s][A
Epoch 2:  16% 15/91 [00:02<00:10,  7.39it/s, loss=6.21, v_num=pqgq]
Validating:   7% 6/82 [00:01<00:10,  6.98it/s][A
Validating:   9% 7/82 [00:01<00:11,  6.60it/s][A
Epoch 2:  20% 18/91 [00:02<00:09,  7.53it/s, loss=6.21, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:09,  8.07it/s][A
Validating:  12% 10/82 [00:01<00:08,  8.41it/s][A
Epoch 2:  23% 21/91 [00:02<00:08,  7.80it/s, loss=6.21, v_num=pqgq]
Validating:  15% 12/82 [00:01<00:07,  9.00it/s][A
Validating:  16% 13/82 [00:01<00:07,  8.65it/s][A
Validating:  17% 14/82 [00:02<00:08,  8.22it/s][A
Epoch 2:  26% 24/91 [00:03<00:08,  7.84it/s, loss=6.21, v_num=pqgq]
Validating:  20% 16/82 [00:02<00:07,  9.24it/s][A
Validating:  21% 17/82 [00:02<00:07,  9.19it/s][A
Epoch 2:  30% 27/91 [00:03<00:07,  8.06it/s, loss=6.21, v_num=pqgq]
Validating:  22% 18/82 [00:02<00:07,  8.64it/s][A
Validating:  24% 20/82 [00:02<00:06,  9.56it/s][A
Epoch 2:  33% 30/91 [00:03<00:07,  8.18it/s, loss=6.21, v_num=pqgq]
Validating:  26% 21/82 [00:02<00:07,  8.32it/s][A
Validating:  27% 22/82 [00:02<00:07,  7.93it/s][A
Epoch 2:  36% 33/91 [00:04<00:07,  8.08it/s, loss=6.21, v_num=pqgq]
Validating:  29% 24/82 [00:03<00:07,  8.23it/s][A
Validating:  32% 26/82 [00:03<00:07,  7.76it/s][A
Epoch 2:  40% 36/91 [00:04<00:06,  8.01it/s, loss=6.21, v_num=pqgq]
Validating:  33% 27/82 [00:03<00:07,  7.74it/s][A
Validating:  35% 29/82 [00:03<00:06,  8.34it/s][A
Epoch 2:  43% 39/91 [00:04<00:06,  8.07it/s, loss=6.21, v_num=pqgq]
Validating:  37% 30/82 [00:03<00:06,  8.18it/s][A
Validating:  39% 32/82 [00:04<00:05,  8.51it/s][A
Epoch 2:  46% 42/91 [00:05<00:06,  8.10it/s, loss=6.21, v_num=pqgq]
Validating:  40% 33/82 [00:04<00:05,  8.78it/s][A
Validating:  41% 34/82 [00:04<00:05,  8.28it/s][A
Validating:  43% 35/82 [00:04<00:05,  8.45it/s][A
Epoch 2:  49% 45/91 [00:05<00:05,  8.12it/s, loss=6.21, v_num=pqgq]
Validating:  44% 36/82 [00:04<00:05,  8.39it/s][A
Validating:  45% 37/82 [00:04<00:05,  8.39it/s][A
Epoch 2:  53% 48/91 [00:05<00:05,  8.16it/s, loss=6.21, v_num=pqgq]
Validating:  48% 39/82 [00:04<00:04,  9.10it/s][A
Validating:  50% 41/82 [00:05<00:04,  8.95it/s][A
Epoch 2:  56% 51/91 [00:06<00:04,  8.22it/s, loss=6.21, v_num=pqgq]
Validating:  51% 42/82 [00:05<00:04,  8.49it/s][A
Validating:  52% 43/82 [00:05<00:04,  8.60it/s][A
Validating:  54% 44/82 [00:05<00:04,  8.12it/s][A
Epoch 2:  59% 54/91 [00:06<00:04,  8.18it/s, loss=6.21, v_num=pqgq]
Validating:  55% 45/82 [00:05<00:05,  7.35it/s][A
Validating:  56% 46/82 [00:05<00:05,  7.13it/s][A
Validating:  57% 47/82 [00:05<00:04,  7.75it/s][A
Epoch 2:  63% 57/91 [00:07<00:04,  8.11it/s, loss=6.21, v_num=pqgq]
Validating:  60% 49/82 [00:06<00:04,  7.84it/s][A
Validating:  61% 50/82 [00:06<00:03,  8.02it/s][A
Epoch 2:  66% 60/91 [00:07<00:03,  8.12it/s, loss=6.21, v_num=pqgq]
Validating:  62% 51/82 [00:06<00:04,  7.32it/s][A
Validating:  65% 53/82 [00:06<00:03,  8.26it/s][A
Epoch 2:  69% 63/91 [00:07<00:03,  8.12it/s, loss=6.21, v_num=pqgq]
Validating:  66% 54/82 [00:06<00:03,  7.26it/s][A
Validating:  67% 55/82 [00:07<00:03,  7.63it/s][A
Validating:  68% 56/82 [00:07<00:03,  8.11it/s][A
Epoch 2:  73% 66/91 [00:08<00:03,  8.08it/s, loss=6.21, v_num=pqgq]
Validating:  70% 57/82 [00:07<00:03,  7.94it/s][A
Validating:  71% 58/82 [00:07<00:02,  8.24it/s][A
Validating:  72% 59/82 [00:07<00:02,  8.48it/s][A
Epoch 2:  76% 69/91 [00:08<00:02,  8.10it/s, loss=6.21, v_num=pqgq]
Validating:  73% 60/82 [00:07<00:02,  7.89it/s][A
Validating:  74% 61/82 [00:07<00:02,  7.60it/s][A
Validating:  76% 62/82 [00:07<00:02,  7.79it/s][A
Epoch 2:  79% 72/91 [00:08<00:02,  8.06it/s, loss=6.21, v_num=pqgq]
Validating:  77% 63/82 [00:07<00:02,  8.13it/s][A
Validating:  78% 64/82 [00:08<00:02,  8.60it/s][A
Epoch 2:  82% 75/91 [00:09<00:01,  8.12it/s, loss=6.21, v_num=pqgq]
Validating:  80% 66/82 [00:08<00:01,  9.00it/s][A
Validating:  82% 67/82 [00:08<00:01,  8.05it/s][A
Epoch 2:  86% 78/91 [00:09<00:01,  8.12it/s, loss=6.21, v_num=pqgq]
Validating:  84% 69/82 [00:08<00:01,  8.45it/s][A
Validating:  85% 70/82 [00:08<00:01,  7.88it/s][A
Validating:  87% 71/82 [00:08<00:01,  8.31it/s][A
Epoch 2:  89% 81/91 [00:09<00:01,  8.11it/s, loss=6.21, v_num=pqgq]
Validating:  88% 72/82 [00:09<00:01,  8.45it/s][A
Validating:  89% 73/82 [00:09<00:01,  8.63it/s][A
Validating:  90% 74/82 [00:09<00:00,  8.75it/s][A
Epoch 2:  92% 84/91 [00:10<00:00,  8.14it/s, loss=6.21, v_num=pqgq]
Validating:  91% 75/82 [00:09<00:00,  8.85it/s][A
Validating:  94% 77/82 [00:09<00:00,  9.35it/s][A
Epoch 2:  96% 87/91 [00:10<00:00,  8.18it/s, loss=6.21, v_num=pqgq]
Validating:  95% 78/82 [00:09<00:00,  8.47it/s][A
Validating:  96% 79/82 [00:09<00:00,  8.25it/s][A
Validating:  98% 80/82 [00:10<00:00,  7.87it/s][A
Epoch 2:  99% 90/91 [00:11<00:00,  8.14it/s, loss=6.21, v_num=pqgq]
Validating:  99% 81/82 [00:10<00:00,  8.35it/s][A
Validating: 100% 82/82 [00:10<00:00,  8.53it/s][A[['University College London', 'Democratic Party for Freedom and Democracy', 'Ministry of Foreign Affairs', 'Democratic Party of Japan', 'Université Laval'], ['stgaard', 'Registrar of Companies of Israel', 'JS Kabylie', 'Yashwantrao', 'NBC News'], ['Rothschild Group', 'Universidad Católica', 'smet nönü', 'eljko eljko', 'Argentinos Juniors'], ['Yves-Alexandre Lehmann', 'Ministry of Foreign Affairs', "Finnish People's Party", 'jpest', 'Democratic Party of the Left'], ['NBC News', 'Eurostar Group', 'Democrat', 'Northampton Town', 'University of Heidelberg'], ['Yves de la Gardie', 'Yves Saint Laurent', 'NBC News', 'Jeremy Corbyn', 'Max Planck'], ['Accrington Stanley', 'eljko orevi', 'Accrington Stanley', 'Pakistan Peoples Party', 'stfold AB'], ['Associated Press', 'University College London', 'NBC News', 'NBC', "Darren O'Connor"], ['NBC News', 'Registrar of the Philippines', 'Yuri Gagarin', 'Argentinos Juniors', 'ONGC'], ['IFK Göteborg', 'Xiamen University', 'Accrington Stanley', 'Yuriy Yakovlev', 'Wells Fargo University'], ['Justice of the Peace', 'Yashwantrao', 'Chancellor of the Peace', 'Ministry of Foreign Affairs', 'Ministry of Foreign Affairs and Trade'], ['Accrington Stanley', 'Universidad de Chile', 'Associated Press', 'Argentinos Juniors', 'University of North Carolina'], ['Yves Saint Laurent', 'Democratic Party', 'Serie B', 'eljezniar', 'Accrington Stanley'], ['Yves Saint Laurent', 'Pennsylvania State Senate', 'David Davidson', 'Yves de la Gardie', 'Maurizio Giacometti'], ['UMNO', 'FC Barcelona', 'Yash Raj', 'Netscape Communications', 'Mauricio Maas'], ['ZANU PF', 'Electoral Commission', 'NBC News', 'Granada Television', 'Al-Ahly'], ['Accrington Stanley', '1860 Munich', 'RC Lens', 'UMP', 'Yuriy Yakovlev'], ['Chancellor of the Peace', 'Justice of the Peace', 'Polski', 'CSKA Sofia', 'Silvio Berlusconi'], ['Democratic Party', 'UMP', 'Yuriy Yakovlev', 'Ministry of Foreign Affairs', 'Democratic Party of Italy'], ['Kimbrough County', 'Serbian Progressive Party', 'NBC News', 'Granada Television', 'Accrington Stanley'], ["Sean O'Brien", 'Xiamen University', 'Fratelli', 'Accrington Stanley', 'eská tpánek'], ['Associated Newspapers', 'lvaro Cárdenas', 'lvaro Cárdenas', 'stgötland', 'Silvio Berlusconi'], ['New York City FC', 'SV Werder Bremen', 'NBC News', 'The New York Times', 'sterreichischer Rundfunk'], ['Jeremy Corbyn', 'Manchester United', 'Grupo Panamericano', 'stlund st', 'Accrington Stanley'], ['Democratic Party of Italy', 'UNESCO', 'Democratic Party of Italy', 'UNESCO', 'Buenos Aires'], ["comte d'Ordre national du Québec", 'Ayr United', 'Nicolás del Castillo', 'Christian Democratic Party', 'CSKA Sofia'], ['BT Group', 'Registrar of Societies', 'Accrington Stanley', 'Finland', 'scar lvarez'], ['NBC News', 'Xerox', "People's Deputy", 'The Kennel Club', 'NBCUniversal'], ['NBC News', 'tefan Bălcescu', 'Granada Television', 'Yuriy Yeltsin', 'Accrington Stanley'], ['Yko Takahashi', 'SV Werder Bremen', 'Accrington Stanley', 'Argentinos Juniors', 'Electoral College of Victoria'], ['West Ham United F.C.', 'RC Lens', 'NBC News', 'Ministry of Foreign Affairs and Trade', 'The New York Times'], ['Argentine Democratic Party', 'Gregorio Aguinaldo', 'Russia', 'Argentine Democratic Party', 'UMP'], ['Labour Party', 'stfold FF', 'Accrington Stanley', 'Yuriy Yakovlev', 'RTÉ'], ['Registrar of Societies', 'United States Secretary of the Navy', 'Günther Schröder', 'FC Barcelona B', 'lvaro lvarez'], ['JS Kabylie', 'Yuriy Kozlov', 'François Xavier', 'Democratic Party of Romania', 'University of the West Indies'], ['Chancellor of the Peace', 'Graeme Davidson', 'Chartered Accountant', 'Democratic Party of Ukraine', 'Paulista lvares'], ['Paulista lvares', 'Democratic Party of Korea', 'Sri Lanka Freedom Party', 'Accrington Stanley', 'Associated Press'], ['Rand Art Museum', 'Democratic Party', 'West Ham United F.C.', 'Al-Hilal', 'Kongregate Group'], ['Argentinos Juniors', 'Granada Television', 'NBC', 'stfold', 'FIA'], ['Office of the Attorney General', 'Democratic Party of Italy', 'Qatar', 'efovi', "Sean O'Connor"], ['The New York Times', 'Democratic Party of Australia', 'Democratic Party of Romania', 'Labour Party', 'Maurcio Gonçalves'], ['Accrington Stanley', 'UNESCO', 'Democratic Party', 'Liaoning Xiaoping', 'Los Angeles Times'], ['Yuriy Ivanov', "People's Party for Freedom and Democracy", 'Accrington Stanley', 'So Paulo FC', ''], ['Universidad Católica', 'Seanad Éireann', 'comte della Repubblica', 'Al-Ahly', 'Democratic Party of Romania'], ['NBC News', 'The Netherlands', 'eljko eljko', 'Democratic Party of the Left', 'Electoral College'], ['Xiao Xiaoping', 'Cumulus Media', 'Jeremy Corbyn', 'Accrington Stanley', 'Granada Television'], ['Buenos Aires', "Darren O'Brien", 'NBC News', 'NBC News', 'Yves Saint Laurent'], ['University of Tokyo', 'stfold', 'Electoral Commission', 'Yves Saint Laurent', 'Democratic Party'], ['University of Lagos', 'Pakistan Peoples Party', 'ukasz Kocielny', 'Office of the Secretary of the Navy', 'Port Vale'], ['Registrar of Societies', 'Universidad Católica', 'Aston Villa', 'Democrat', 'Registrar of Companies'], ['Accrington Stanley', 'stanbul BB', 'François-Joseph Lefèvre', 'Ministry of Foreign Affairs and Trade', 'Ministry of Foreign Affairs'], ['Democratic Party of Lithuania', 'Accrington Stanley', 'NBC News', 'Chartered Accountant', 'Electoral Argentine'], ['Electoral Elect', 'IFK Göteborg', "Lithuanian People's Party", 'SV Werder Bremen', 'Granada Television'], ["comte d'Ordre national du Québec", 'The New York Times', 'ONGC', 'DMK', 'NBC'], ['Bergen Commuter Rail', 'BJP', 'Romanian Democratic Party', 'lvaro Uribe', 'United States Secretary of the Navy'], ['Registrar of Societies', 'Jeremy Corbyn', 'Honolulu', 'Yuriy Yakovlev', 'Yves Saint Laurent'], ['Eberhard Schröder', 'Democratic Party', 'RC Lens', 'lvaro lvarez', 'Yuriy Yelchin'], ['lsk SK', 'Democratic Party', 'Democratic Party of Italy', 'Accrington Stanley', 'University College Dublin'], ['Advisory Committee on the Status of Women', 'Argentinos Juniors', 'AKP', 'Justice of the Peace', 'UMP'], ['Democratic Party of Romania', 'Seanad Éireann', 'NBC', 'So Paulo FC', ''], ['Democratic Party of Japan', 'Yenisey Krasnodar', "comte d'Orsay", 'Pakistan Peoples Party', 'Serie B'], ['Democratic Party of Italy', 'Universidad Católica', 'Seoul National University', 'Democratic Party of Italy', 'Maurizio Graziani'], ['Maurizio Di Luca', 'Democratic Party', 'UMP', 'Accrington Stanley', 'Al-Ahli'], ['Yushchenko', 'Accrington Stanley', 'Yuriy Yakovlev', '', 'University of the Netherlands'], ['BJP', 'The New York Times', 'Hickory Newspapers', 'Democratic Party of Italy', 'NBC News'], ['University of Stellenbosch', 'Accrington Stanley', 'Bangladesh Awami League', 'Yves Lehmann', 'hÉireann'], ['Democratic Party of Romania', 'University of Szeged', 'Westfield Wheaton', 'Yves Saint Laurent-de-Ville', 'Silvio Berlusconi'], ['Argentinos Juniors', 'Argyle', 'Democrat', 'United States Department of the Treasury', 'Electoral Elect'], ['YES', 'UNESCO', 'Associated Press', 'lvaro lvarez', 'University of Tbilisi'], ['Yves de la Gardie', 'François Mitterrand', 'SK Rapid Wien', 'François-Joseph Lefèvre', 'Democratic Party of the Left'], ['Argentinos Juniors', 'Office of the Secretary of the Navy', 'University of Toronto', 'Boxer TV LLC', 'Charlotte Hornets LLC'], ['FC Barcelona', 'SK S.C.', 'Universidad Católica', 'Silvio Berlusconi', 'Judith A. Sullivan'], ['UMP', 'The New York Times', 'Seanad Éireann', 'CSKA Sofia', 'NBC News'], ['FC Porto', 'Shamrock Rovers', 'Darren McDermott', 'Bangladesh Nationalist Party', 'Yuriy Yakovlev'], ['Government of India', 'KS ód', "St. Mary's College", 'Granada Television', 'NBC News'], ['Argentinos Juniors', 'David Jones', 'Accrington Stanley', 'Dundee United', 'Norm McKay'], ['UNESCO', 'Associated Press', 'Maurizio Giacometti', "People's Party", 'Serbian Progressive Party'], ['FIA', 'Universidad Católica', 'UNESCO', 'Accademia Nazionale di Belle Arti', 'Argentinos Juniors'], ['University College London', 'NBC News', 'Hans-Joachim Schröder', 'strm', 'SK Brann'], ['Registrar of Societies', 'Ministry of Foreign Affairs and Trade', 'Chief of Police', 'UMP', 'François-Joseph Pau'], ['Yokohama FC', 'Yves Saint Laurent', 'PEN International', 'SK Rapid Wien', 'Chancellor of the Peace'], ['Mohamed Al-Hassan', 'Labour Party', 'NBC News', 'Auckland City Council', 'Accademia Italiana']]
Epoch 2: 100% 91/91 [00:11<00:00,  8.03it/s, loss=6.21, v_num=pqgq]
                                               [A
Epoch 2:   0% 0/91 [00:00<?, ?it/s, loss=6.21, v_num=pqgq]         
Epoch 3:   0% 0/91 [00:00<?, ?it/s, loss=6.21, v_num=pqgq]
Epoch 3:   1% 1/91 [00:00<00:39,  2.31it/s, loss=6.21, v_num=pqgq]
Epoch 3:   2% 2/91 [00:00<00:21,  4.15it/s, loss=6.21, v_num=pqgq]
Epoch 3:   3% 3/91 [00:00<00:17,  5.11it/s, loss=6.21, v_num=pqgq]
Epoch 3:   3% 3/91 [00:00<00:17,  5.11it/s, loss=5.96, v_num=pqgq]
Epoch 3:   4% 4/91 [00:00<00:13,  6.31it/s, loss=5.96, v_num=pqgq]
Epoch 3:   5% 5/91 [00:00<00:11,  7.36it/s, loss=5.96, v_num=pqgq]
Epoch 3:   7% 6/91 [00:00<00:10,  7.73it/s, loss=5.96, v_num=pqgq]
Epoch 3:   7% 6/91 [00:00<00:10,  7.73it/s, loss=5.82, v_num=pqgq]
Epoch 3:   8% 7/91 [00:00<00:09,  8.49it/s, loss=5.82, v_num=pqgq]
Epoch 3:   9% 8/91 [00:00<00:09,  9.18it/s, loss=5.82, v_num=pqgq]
Epoch 3:  10% 9/91 [00:01<00:09,  8.76it/s, loss=5.82, v_num=pqgq]
Epoch 3:  10% 9/91 [00:01<00:09,  8.76it/s, loss=5.61, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:40,  2.00it/s][A
Validating:   2% 2/82 [00:00<00:21,  3.72it/s][A
Epoch 3:  13% 12/91 [00:01<00:10,  7.32it/s, loss=5.61, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:15,  4.98it/s][A
Validating:   5% 4/82 [00:00<00:13,  5.98it/s][A
Epoch 3:  16% 15/91 [00:01<00:09,  7.69it/s, loss=5.61, v_num=pqgq]
Validating:   7% 6/82 [00:01<00:10,  7.53it/s][A
Validating:   9% 7/82 [00:01<00:10,  6.97it/s][A
Epoch 3:  20% 18/91 [00:02<00:09,  7.70it/s, loss=5.61, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:08,  8.23it/s][A
Validating:  12% 10/82 [00:01<00:08,  8.57it/s][A
Epoch 3:  23% 21/91 [00:02<00:08,  8.00it/s, loss=5.61, v_num=pqgq]
Validating:  15% 12/82 [00:01<00:07,  9.49it/s][A
Validating:  16% 13/82 [00:01<00:07,  8.63it/s][A
Validating:  17% 14/82 [00:01<00:07,  8.51it/s][A
Epoch 3:  26% 24/91 [00:02<00:08,  8.02it/s, loss=5.61, v_num=pqgq]
Validating:  20% 16/82 [00:02<00:07,  9.11it/s][A
Epoch 3:  30% 27/91 [00:03<00:07,  8.27it/s, loss=5.61, v_num=pqgq]
Validating:  22% 18/82 [00:02<00:06, 10.02it/s][A
Validating:  24% 20/82 [00:02<00:05, 10.85it/s][A
Epoch 3:  33% 30/91 [00:03<00:07,  8.55it/s, loss=5.61, v_num=pqgq]
Validating:  27% 22/82 [00:02<00:06,  9.09it/s][A
Epoch 3:  36% 33/91 [00:03<00:06,  8.48it/s, loss=5.61, v_num=pqgq]
Validating:  29% 24/82 [00:03<00:06,  8.70it/s][A
Validating:  32% 26/82 [00:03<00:06,  9.09it/s][A
Epoch 3:  40% 36/91 [00:04<00:06,  8.47it/s, loss=5.61, v_num=pqgq]
Validating:  34% 28/82 [00:03<00:05,  9.70it/s][A
Epoch 3:  43% 39/91 [00:04<00:06,  8.58it/s, loss=5.61, v_num=pqgq]
Validating:  37% 30/82 [00:03<00:05,  9.22it/s][A
Validating:  39% 32/82 [00:03<00:05,  9.61it/s][A
Epoch 3:  46% 42/91 [00:04<00:05,  8.65it/s, loss=5.61, v_num=pqgq]
Validating:  40% 33/82 [00:03<00:05,  9.19it/s][A
Validating:  41% 34/82 [00:04<00:05,  8.79it/s][A
Validating:  43% 35/82 [00:04<00:05,  9.02it/s][A
Epoch 3:  49% 45/91 [00:05<00:05,  8.62it/s, loss=5.61, v_num=pqgq]
Validating:  45% 37/82 [00:04<00:04,  9.81it/s][A
Epoch 3:  53% 48/91 [00:05<00:04,  8.77it/s, loss=5.61, v_num=pqgq]
Validating:  48% 39/82 [00:04<00:04, 10.07it/s][A
Validating:  50% 41/82 [00:04<00:03, 10.48it/s][A
Epoch 3:  56% 51/91 [00:05<00:04,  8.85it/s, loss=5.61, v_num=pqgq]
Validating:  52% 43/82 [00:04<00:04,  9.25it/s][A
Validating:  54% 44/82 [00:05<00:04,  9.07it/s][A
Epoch 3:  59% 54/91 [00:06<00:04,  8.78it/s, loss=5.61, v_num=pqgq]
Validating:  55% 45/82 [00:05<00:04,  8.72it/s][A
Validating:  57% 47/82 [00:05<00:03,  9.36it/s][A
Epoch 3:  63% 57/91 [00:06<00:03,  8.81it/s, loss=5.61, v_num=pqgq]
Validating:  59% 48/82 [00:05<00:03,  9.32it/s][A
Validating:  60% 49/82 [00:05<00:03,  8.32it/s][A
Epoch 3:  66% 60/91 [00:06<00:03,  8.80it/s, loss=5.61, v_num=pqgq]
Validating:  62% 51/82 [00:05<00:03,  9.68it/s][A
Validating:  65% 53/82 [00:06<00:02, 10.53it/s][A
Epoch 3:  69% 63/91 [00:07<00:03,  8.93it/s, loss=5.61, v_num=pqgq]
Validating:  67% 55/82 [00:06<00:02, 10.34it/s][A
Epoch 3:  73% 66/91 [00:07<00:02,  8.97it/s, loss=5.61, v_num=pqgq]
Validating:  70% 57/82 [00:06<00:02,  9.52it/s][A
Validating:  71% 58/82 [00:06<00:02,  9.45it/s][A
Validating:  72% 59/82 [00:06<00:02,  9.38it/s][A
Epoch 3:  76% 69/91 [00:07<00:02,  8.94it/s, loss=5.61, v_num=pqgq]
Validating:  74% 61/82 [00:06<00:02, 10.03it/s][A
Validating:  76% 62/82 [00:06<00:02,  9.82it/s][A
Epoch 3:  79% 72/91 [00:08<00:02,  8.99it/s, loss=5.61, v_num=pqgq]
Validating:  77% 63/82 [00:07<00:01,  9.66it/s][A
Validating:  78% 64/82 [00:07<00:01,  9.27it/s][A
Validating:  79% 65/82 [00:07<00:01,  9.19it/s][A
Epoch 3:  82% 75/91 [00:08<00:01,  8.98it/s, loss=5.61, v_num=pqgq]
Validating:  80% 66/82 [00:07<00:01,  9.37it/s][A
Validating:  82% 67/82 [00:07<00:01,  8.56it/s][A
Epoch 3:  86% 78/91 [00:08<00:01,  9.00it/s, loss=5.61, v_num=pqgq]
Validating:  84% 69/82 [00:07<00:01,  8.83it/s][A
Validating:  87% 71/82 [00:07<00:01,  9.62it/s][A
Epoch 3:  89% 81/91 [00:08<00:01,  9.01it/s, loss=5.61, v_num=pqgq]
Validating:  88% 72/82 [00:08<00:01,  9.30it/s][A
Validating:  90% 74/82 [00:08<00:00,  9.06it/s][A
Epoch 3:  92% 84/91 [00:09<00:00,  9.00it/s, loss=5.61, v_num=pqgq]
Validating:  91% 75/82 [00:08<00:00,  9.07it/s][A
Validating:  94% 77/82 [00:08<00:00,  8.83it/s][A
Epoch 3:  96% 87/91 [00:09<00:00,  8.98it/s, loss=5.61, v_num=pqgq]
Validating:  96% 79/82 [00:08<00:00,  9.42it/s][A
Validating:  98% 80/82 [00:08<00:00,  9.37it/s][A
Epoch 3:  99% 90/91 [00:09<00:00,  9.02it/s, loss=5.61, v_num=pqgq]
Validating: 100% 82/82 [00:09<00:00, 10.07it/s][A[['University of the West of England', "People's Party for Freedom and Democracy", 'interior ministry', 'Democratic Party', 'École nationale supérieure des mines'], ['Denmark', 'interior ministry', 'Yokohama FC', 'Yuriy Yakovlev', 'Jeremy Corbyn'], ['Deutsche Bahn', '', 'smet nönü', 'Yuriy Ivanov', 'Argentine Primera B'], ['Nicolaus Copernicus', 'interior ministry', "People's Party for Freedom and Democracy", 'interior ministry', "People's Party for Freedom and Democracy"], ['United States of America', 'Eurostar', 'Electoral Commissioner', 'Accrington Stanley', 'ETH Zurich'], ['Yuriy Yushchenko', 'RC Lens', 'Yvette Nicolet', 'Labour Party', 'Max Planck'], ['England Saxons', 'eljko orevi', 'England Saxons', 'Bangladesh Nationalist Party', 'st nad Labe'], ['Yvette Nicole Brown', 'Emmanuel College', 'United States Congress', 'United States Department of Justice', "Darren O'Brien"], ['United States Congress', 'Prime Minister of the Philippines', 'U.S. Secretary of Transportation', 'Argentinos Juniors', 'ONGC'], ['IFK Göteborg', 'Xinjiang', 'YMCA', 'Yuriy Yakovlev', 'Wells Fargo Corporation'], ['interior ministry', 'Federal Emergency Management Agency', 'interior ministry', "People's Representative of Singapore", 'interior ministry'], ['England Saxons', 'Buenos Aires', 'Jeremy Corbyn', 'Argentinos Juniors', 'University of Virginia'], ['Yuriy Yelchin', 'Democratic Party', 'Luca S.C.', 'eljezniar', 'England Saxons'], ['sterreichische Physik', 'Pennsylvania State Senate', 'Jeremy Corbyn', 'Yves Saint-Léger', 'Nicolaas Kübler'], ['Democratic Party of Malaysia', 'FC Barcelona', 'BJP', 'Netscape', 'Mauricio Maas'], ['interior ministry', 'Electoral Commission', 'United States Department of the Treasury', 'Jeremy Corbyn', 'Yves Saint Laurent'], ['England Saxons', 'SV Werder Bremen', 'RC Strasbourg', 'Democratic Party', 'Jeremy Corbyn'], ['interior ministry', 'interior ministry', 'Polska', 'UE Lleida', 'Livorno'], ['Democratic Party', 'UMP', 'International Shooting Sport Federation', 'interior ministry', 'Democratic Party'], ['North Carolina State University', 'Democratic Party', 'Jeremy Corbyn', 'Yvette Cooper', 'England Saxons'], ['interior ministry', 'Mainland China', 'Gruppo Editore Italiana', 'England Saxons', 'eská tpán'], ['United States Congress', 'lvaro Cárdenas', 'lvaro Uribe', 'interior ministry', 'Turin City Council'], ['England and Wales', 'SV Werder Bremen', 'NBC News', 'Jeremy Corbyn', 'Electoral Commission'], ['Jeremy Corbyn', 'England Saxons', 'Grupo Panamericano', 'sgeir stgaard', 'England and Wales'], ['Democratic Party', 'UNESCO', 'Democratic Party', '20 June 2014', 'Buenos Aires'], ["comte d'État", 'Carlton', 'Nicolás del Ro', 'Democratic Party', 'Yokohama FC'], ['Ofcom', 'interior ministry', 'England Saxons', '', 'Christian Democratic Party'], ['United States Department of Justice', 'Microsoft Corporation', "People's Deputy of China", 'The Nature Conservancy', 'NBCUniversal'], ['Democratic Party of New York', 'tefan erban', 'Jeremy Corbyn', 'Yuriy Yeltsin', 'England Saxons'], ['Yko Takahashi', 'SK Slavia Prague', 'England Saxons', 'Argentinos Juniors', 'interior ministry'], ['England Saxons', 'RC Lens', 'United States Congress', 'interior ministry', 'Yvette Nicolet'], ["People's Party for Freedom and Democracy", 'Batangas', 'Russia', "People's Party for Freedom and Democracy", 'Democratic Party'], ['Democratic Party', 'stfold', 'England and Wales', 'Yuriy Yushchenko', 'United States Senate'], ['interior ministry', 'interior ministry', 'Nicolaus Copernicus', 'lvaro Obregón', 'lvaro Cárdena'], ['JS Kabylie', 'Yuriy Kozlov', 'Emmanuel Macron', 'Party of Regions', 'University of the West Indies'], ['Chief of the Navy', 'Jeremy Corbyn', 'interior ministry', 'Party of Regions', 'So Paulo'], ['So Paulo', 'Democratic Party', 'Democratic Progressive Party', 'England Saxons', 'Jeremy Corbyn'], ['The Art Institute of Chicago', 'Democratic Party', 'England Saxons', 'stanbul', 'Kongregate'], ['lvaro Uribe', 'Jeremy Corbyn', 'United States Department of Justice', 're Schultz', 'FIA'], ['Secretary of the Navy', 'Democratic Party', 'Qatari', 'interior ministry', 'Secretary of the Navy'], ['United States Congress', 'Democratic Party', 'Party of Regions', 'Conservative Party', 'Maurcio Alves'], ['England Saxons', '', "People's Party for Freedom and Democracy", 'Liaoning City Council', 'News Corporation'], ['Yuriy Ivanov', "People's Party for Freedom and Democracy", 'England and Wales', 'guila', 'interior ministry'], ['Buenos Aires', 'Seanad', 'comte di Stato Italiane', 'Saudi Arabia', 'Party of Regions'], ['Yvette Nicole Brown', 'UEFA', 'Yuriy Yuriyev', "People's Party of Romania", 'interior ministry'], ['Changhua County', 'Media General', 'Jeremy Corbyn', 'England and Wales', 'Jeremy Corbyn'], ['Buenos Aires', "Darren O'Brien", 'Democrat', 'Yvette Nicole Brown', ''], ['University of Tokyo', 'Democratic Party of Norway', 'interior ministry', 'UNESCO', "People's Party for Freedom and Democracy"], ['University of the West Indies', 'Bangladesh Nationalist Party', 'ukasz Kociuszko', 'Secretary of the Navy', 'England Saxons'], ['Electoral Commissioner', 'Buenos Aires', 'England Saxons', 'Chief of Staff', 'interior ministry'], ['England and Wales', 'stanbul', 'Jacques-Louis David', 'interior ministry', 'interior ministry'], ['Democratic Party of Lithuania', 'England Saxons', 'NBC', 'Chief of the Navy', 'interior ministry'], ['interior ministry', 'SK Rapid Wien', 'Democratic Party of Lithuania', 'Yokohama FC', 'Jeremy Corbyn'], ["comte d'Or", 'Jeremy Corbyn', 'Yash Raj', 'Democratic Progressive Party', 'United States Congress'], ['Bergen Commuter Rail', 'BJP', 'tefan cel Mare', 'Texans', 'Secretary of the Navy'], ['interior ministry', 'Jeremy Corbyn', 'Honolulu', 'Yuriy Yakovlev', 'Electoral Commission'], ['Maurizio Bianchi', 'Democratic Party', 'RC Lens', 'lvaro Cárdenas', 'Yuriy Yelchin'], ['lvaro Uribe', "People's Party of Brazil", 'Democratic Party', 'England Saxons', 'University of Virginia'], ['Chief of the Navy', 'Argentinos Juniors', "People's Party for Freedom and Democracy", 'interior ministry', 'Democratic Party'], ['Party of Regions', 'interior ministry', 'United States Congress', 'guila', 'interior ministry'], ['Democratic Party', 'Yuriy Yakovlev', "comte d'Etat", 'Bangladesh Nationalist Party', 'Serie A'], ['Democratic Party', 'lvaro Uribe', 'University of South Korea', 'Democratic Party', 'lvaro Uribe'], ['Maurizio Cataldi', 'Democratic Party', 'Democratic Party', 'England and Wales', 'AQAP'], ['Yuriy Yakovlev', 'England Saxons', 'Yves Saint-Laurent', '', '15 June 1894'], ['Yash Chopra', 'Jeremy Corbyn', 'Hickory Newspapers Inc.', "People's Party of Italy", 'NBC News'], ['University of the Netherlands', 'Accrington Stanley', 'Bangladesh Nationalist Party', 'Yves Lehmann', 'hEoin'], ['Party of Regions', 'ár nad Labem', 'Westfield Wheaton', 'Yves Saint Laurent', 'Maurizio Giacometti'], ['FC Barcelona', 'Granada CF', 'Secretary of the Navy', 'United States Department of Energy', 'interior ministry'], ['Yokohama', 'UNESCO', 'United States Senate', 'lvaro Cárdenas', 'University of Tehran'], ['Rio Tinto', 'François Mitterrand', 'VP', 'Jacques-Louis David', "People's Party of China"], ['Argentinos Juniors', 'Secretary of the Navy', 'MIT', 'Boxer TV LLC', 'Charlotte Hornets LLC'], ['FC Barcelona', 'SLFP', 'Argentine Primera B', 'Silvio Berlusconi', 'Judith A. McKay'], ['Democratic Party', 'United States Department of Justice', 'Seanad Éireann', 'CSKA Moscow', 'Yvette Nicolet'], ['RC Lens', 'hÉireann', 'Darren McKinley', 'Bangladesh Nationalist Party', "People's Party for Freedom and Democracy"], ['interior ministry', 'KS ód', 'Emmanuel College', 'Jeremy Corbyn', 'Yvette Nicolet'], ['Argentinos Juniors', 'Welsh Labour', 'Carlton Football Club', 'Scotland', 'Boise State'], ['UNESCO', 'United States Department of Justice', 'Maurizio Giacometti', "People's Party for Freedom and Democracy", 'Democratic Party'], ['FIA', 'UE Lleida', 'François Hollande', 'UNESCO', 'FC Barcelona'], ['Emmanuel College', 'NBC News', 'stgötl', 'interior ministry', 'SK Rapid Wien'], ['interior ministry', 'interior ministry', 'Chief of the Navy', "People's Party for Freedom and Democracy", 'Pau'], ['Yokohama FC', 'Jeremy Corbyn', 'PEN International', 'England', 'interior ministry'], ['Sahrawi', 'Conservative Party', 'Democratic Party', 'Auckland City Council', 'UNESCO']]
Epoch 3: 100% 91/91 [00:10<00:00,  8.92it/s, loss=5.61, v_num=pqgq]
                                               [A
Epoch 3:   0% 0/91 [00:00<?, ?it/s, loss=5.61, v_num=pqgq]         
Epoch 4:   0% 0/91 [00:00<?, ?it/s, loss=5.61, v_num=pqgq]
Epoch 4:   1% 1/91 [00:00<00:42,  2.10it/s, loss=5.61, v_num=pqgq]
Epoch 4:   2% 2/91 [00:00<00:23,  3.83it/s, loss=5.61, v_num=pqgq]
Epoch 4:   3% 3/91 [00:00<00:18,  4.80it/s, loss=5.61, v_num=pqgq]
Epoch 4:   3% 3/91 [00:00<00:18,  4.80it/s, loss=5.39, v_num=pqgq]
Epoch 4:   4% 4/91 [00:00<00:14,  5.94it/s, loss=5.39, v_num=pqgq]
Epoch 4:   5% 5/91 [00:00<00:12,  6.95it/s, loss=5.39, v_num=pqgq]
Epoch 4:   7% 6/91 [00:00<00:11,  7.35it/s, loss=5.39, v_num=pqgq]
Epoch 4:   7% 6/91 [00:00<00:11,  7.34it/s, loss=5.2, v_num=pqgq] 
Epoch 4:   8% 7/91 [00:00<00:10,  8.09it/s, loss=5.2, v_num=pqgq]
Epoch 4:   9% 8/91 [00:00<00:09,  8.79it/s, loss=5.2, v_num=pqgq]
Epoch 4:  10% 9/91 [00:01<00:09,  8.44it/s, loss=5.2, v_num=pqgq]
Epoch 4:  10% 9/91 [00:01<00:09,  8.44it/s, loss=5.07, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:39,  2.05it/s][A
Epoch 4:  13% 12/91 [00:01<00:10,  7.28it/s, loss=5.07, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:17,  4.48it/s][A
Validating:   6% 5/82 [00:00<00:11,  6.79it/s][A
Epoch 4:  16% 15/91 [00:01<00:09,  7.61it/s, loss=5.07, v_num=pqgq]
Validating:   9% 7/82 [00:01<00:10,  7.15it/s][A
Epoch 4:  20% 18/91 [00:02<00:09,  7.76it/s, loss=5.07, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:08,  8.19it/s][A
Validating:  12% 10/82 [00:01<00:08,  8.22it/s][A
Epoch 4:  23% 21/91 [00:02<00:08,  7.97it/s, loss=5.07, v_num=pqgq]
Validating:  15% 12/82 [00:01<00:07,  8.87it/s][A
Validating:  17% 14/82 [00:01<00:07,  9.43it/s][A
Epoch 4:  26% 24/91 [00:02<00:08,  8.22it/s, loss=5.07, v_num=pqgq]
Validating:  20% 16/82 [00:01<00:05, 11.03it/s][A
Epoch 4:  30% 27/91 [00:03<00:07,  8.67it/s, loss=5.07, v_num=pqgq]
Validating:  22% 18/82 [00:02<00:05, 11.39it/s][A
Validating:  24% 20/82 [00:02<00:05, 11.89it/s][A
Epoch 4:  33% 30/91 [00:03<00:06,  8.94it/s, loss=5.07, v_num=pqgq]
Validating:  27% 22/82 [00:02<00:06,  9.89it/s][A
Epoch 4:  36% 33/91 [00:03<00:06,  8.89it/s, loss=5.07, v_num=pqgq]
Validating:  29% 24/82 [00:02<00:05,  9.67it/s][A
Validating:  32% 26/82 [00:02<00:05,  9.75it/s][A
Epoch 4:  40% 36/91 [00:04<00:06,  8.89it/s, loss=5.07, v_num=pqgq]
Validating:  34% 28/82 [00:03<00:05,  9.59it/s][A
Validating:  35% 29/82 [00:03<00:05,  9.51it/s][A
Epoch 4:  43% 39/91 [00:04<00:05,  8.91it/s, loss=5.07, v_num=pqgq]
Validating:  38% 31/82 [00:03<00:04, 10.26it/s][A
Epoch 4:  46% 42/91 [00:04<00:05,  9.03it/s, loss=5.07, v_num=pqgq]
Validating:  40% 33/82 [00:03<00:04,  9.88it/s][A
Validating:  43% 35/82 [00:03<00:04,  9.79it/s][A
Epoch 4:  49% 45/91 [00:04<00:05,  9.06it/s, loss=5.07, v_num=pqgq]
Validating:  45% 37/82 [00:04<00:04, 10.28it/s][A
Epoch 4:  53% 48/91 [00:05<00:04,  9.20it/s, loss=5.07, v_num=pqgq]
Validating:  48% 39/82 [00:04<00:03, 10.79it/s][A
Validating:  50% 41/82 [00:04<00:03, 11.22it/s][A
Epoch 4:  56% 51/91 [00:05<00:04,  9.33it/s, loss=5.07, v_num=pqgq]
Validating:  52% 43/82 [00:04<00:03, 11.48it/s][A
Epoch 4:  59% 54/91 [00:05<00:03,  9.44it/s, loss=5.07, v_num=pqgq]
Validating:  55% 45/82 [00:04<00:03, 10.01it/s][A
Validating:  57% 47/82 [00:04<00:03, 10.76it/s][A
Epoch 4:  63% 57/91 [00:06<00:03,  9.43it/s, loss=5.07, v_num=pqgq]
Validating:  60% 49/82 [00:05<00:03, 10.63it/s][A
Epoch 4:  66% 60/91 [00:06<00:03,  9.50it/s, loss=5.07, v_num=pqgq]
Validating:  62% 51/82 [00:05<00:02, 11.29it/s][A
Validating:  65% 53/82 [00:05<00:02, 12.00it/s][A
Epoch 4:  69% 63/91 [00:06<00:02,  9.64it/s, loss=5.07, v_num=pqgq]
Validating:  67% 55/82 [00:05<00:02, 11.82it/s][A
Epoch 4:  73% 66/91 [00:06<00:02,  9.71it/s, loss=5.07, v_num=pqgq]
Validating:  70% 57/82 [00:05<00:02, 11.52it/s][A
Validating:  72% 59/82 [00:05<00:01, 11.56it/s][A
Epoch 4:  76% 69/91 [00:07<00:02,  9.77it/s, loss=5.07, v_num=pqgq]
Validating:  74% 61/82 [00:06<00:01, 11.59it/s][A
Epoch 4:  79% 72/91 [00:07<00:01,  9.81it/s, loss=5.07, v_num=pqgq]
Validating:  77% 63/82 [00:06<00:01, 11.58it/s][A
Validating:  79% 65/82 [00:06<00:01, 11.77it/s][A
Epoch 4:  82% 75/91 [00:07<00:01,  9.91it/s, loss=5.07, v_num=pqgq]
Validating:  82% 67/82 [00:06<00:01, 11.04it/s][A
Epoch 4:  86% 78/91 [00:07<00:01,  9.92it/s, loss=5.07, v_num=pqgq]
Validating:  84% 69/82 [00:06<00:01, 10.26it/s][A
Validating:  87% 71/82 [00:07<00:01, 10.06it/s][A
Epoch 4:  89% 81/91 [00:08<00:01,  9.86it/s, loss=5.07, v_num=pqgq]
Validating:  89% 73/82 [00:07<00:00,  9.79it/s][A
Validating:  90% 74/82 [00:07<00:00,  9.68it/s][A
Epoch 4:  92% 84/91 [00:08<00:00,  9.84it/s, loss=5.07, v_num=pqgq]
Validating:  93% 76/82 [00:07<00:00, 10.06it/s][A
Epoch 4:  96% 87/91 [00:08<00:00,  9.84it/s, loss=5.07, v_num=pqgq]
Validating:  95% 78/82 [00:07<00:00, 10.47it/s][A
Validating:  98% 80/82 [00:07<00:00, 11.48it/s][A
Epoch 4:  99% 90/91 [00:09<00:00,  9.96it/s, loss=5.07, v_num=pqgq]
Validating: 100% 82/82 [00:08<00:00, 11.27it/s][A[['England Saxons', 'Electoral Commission', 'interior ministry', 'Democratic Party of Japan', 'École nationale supérieure des sciences'], ['Capital Region', 'interior ministry', 'Yokohama FC', 'Young Union', 'Brexit'], ['Y Combinator', 'France 3', 'smet nönü', 'Yuriy Kozlov', 'Argentine Primera B'], ['Party of the Greens', 'interior ministry', 'Democrat Party', 'interior ministry', 'Democratic Party'], ['United States of America', 'Eurostar', 'Chartered Accountant', 'England Saxons', 'University of Virginia'], ['Drottningholm', 'RC Lens', 'United States of America', 'England and Wales', 'Max Planck Society'], ['England Saxons', 'eljko eljko', 'England Saxons', 'Bangladesh Nationalist Party', 'Yves Saint Laurent'], ['Washington, D.C.', 'University College London', 'Washington, D.C.', 'United States Department of Energy', "Darren O'Connor"], ['Washington, D.C.', 'interior ministry', 'Delta', 'Argentine Primera B', 'FC Pune City'], ['IFK Göteborg', 'Xinhua', 'England and Wales', 'Yuriy Yeltsin', 'Wells Fargo Corporation'], ['interior ministry', 'Federal Emergency Management Agency', 'interior ministry', "People's Deputy of Singapore", 'interior ministry'], ['England Saxons', 'Buenos Aires', 'Brexit', 'Argentine Primera B', 'Washington University'], ['Yves Saint Laurent', 'Conservative Party', 'FC Juventus', 'Serbia & Montenegro', 'England and Wales'], ['France 3', 'Pennsylvania State Senate', "Sainsbury's", 'Rally for Freedom and Democracy', 'Mauricio Macri'], ['UMNO', 'FC Barcelona', 'BJP', 'Netscape', 'Thierry Henry'], ['interior ministry', 'interior ministry', 'Australia', 'England and Wales', 'FC Barcelona'], ['England Saxons', 'England and Wales', 'FC Nantes', 'UMP', 'Yvette Cooper'], ['Chartered Accountant', 'interior ministry', 'Polski', 'Yokohama FC', 'Livorno'], ['Democratic Party', 'UMP', 'International Shooting Sport Federation', 'interior ministry', 'Democratic Party'], ['North Carolina State University', 'Democratic Party', 'Brexit', 'Labour Party', 'England Saxons'], ['interior ministry', 'UNESCO', 'Gruppo Fratelli', 'England and Wales', 'eljko eljko'], ['United States Department of Education', 'EEA', 'Cristiano Ronaldo', 'interior ministry', 'Turin City Council'], ['England and Wales', 'SV Werder Bremen', 'United States of America', 'Jeremy Corbyn', 'France 5'], ['England & Wales', 'England and Wales', 'Grupo Panamericano', 'Bjrn Bjrnson', 'England and Wales'], ['Democratic Party', 'UNESCO', 'Democratic Party', 'UNESCO', 'Buenos Aires'], ['interior ministry', 'England and Wales', 'Nicolás Maduro', 'Christian Democratic Party', 'England Saxons'], ['4chan', 'interior ministry', 'England Saxons', 'Yuriy Yaroslavl', 'Christian Democratic Party'], ['United States of America', 'iCloud', "People's Deputy of China", 'The Nature Conservancy', 'NBCUniversal'], ['Washington, D.C.', 'tefan tefan', 'England and Wales', 'Yuriy Petrovich Putin', 'England Saxons'], ['Kyto City Council', 'SK Rapid Wien', 'England Saxons', 'Argentinos Juniors', 'interior ministry'], ['England and Wales', 'RC Strasbourg', 'United States Department of Energy', 'interior ministry', 'United States of America'], ["People's Party for Freedom and Democracy", 'Batangas Government', 'Russia', 'Argentine Nationalist Party', 'UMP'], ['Labour Party', 'UEFA', 'England Saxons', 'Yuriy Zhukov', 'Brexit'], ['interior ministry', 'interior ministry', 'German Mathematical Society', 'England Saxons', 'Mauricio Macri'], ['YES', 'Verkhovna Rada', 'Emmanuel Macron', 'Democratic Party', 'University of the West of Nigeria'], ['interior ministry', 'Labour Party', 'interior ministry', 'CPSU', 'So Paulo'], ['So Paulo', 'Democratic Party', 'Democrat Party', 'England Saxons', 'England & Wales'], ['The Art Institute of Chicago', 'Democratic Party', 'England Saxons', 'Saudi Arabia', 'Kongregate'], ['Argentinos Juniors', 'England and Wales', 'Washington, D.C.', 'stfold', 'FIA'], ['Democrat', 'Democratic Party', 'Qatari Government', 'interior ministry', 'interior ministry'], ['United States Department of Education', 'Conservative Party', 'Democratic Party', 'Labour Party', 'Maurcio Alves'], ['England Saxons', 'France 5', "People's Party", 'Liaoning City Council', 'News Corporation'], ['Symbolic Logic', "People's Party", 'England Saxons', 'guila', 'interior ministry'], ['France 3', 'Elect', 'interior ministry', 'FC Al Jazeera English', 'Democratic Party'], ['United States Senate', 'France 3', 'eljko eljko', "People's Party for Freedom and Democracy", 'interior ministry'], ['Changhua City Council', 'Entercom', 'Jeremy Corbyn', 'England Saxons', 'England and Wales'], ['UNESCO', 'LSU', 'France 5', 'United States Senate', 'United States of America'], ['University of Tokyo', 'stfold', 'interior ministry', 'France 2', 'Democrat Party'], ['University of Lagos', 'Bangladesh Nationalist Party', 'ukasz Kubot', 'Democrat', 'England Saxons'], ['of the People', 'Colombia', 'England Saxons', 'interior ministry', 'interior ministry'], ['England Saxons', 'SK Rapid Wien', 'Jacques-Louis David', 'interior ministry', 'interior ministry'], ['Democratic Party of Lithuania', 'England Saxons', 'The New York Times', 'Chartered Accountant', 'interior ministry'], ['interior ministry', 'FC Barcelona', 'Democratic Party of Lithuania', 'England and Wales', 'Brexit'], ['interior ministry', 'The Guardian', 'Yokohama FC', 'Democrat Party', 'United States Department of Defense'], ['Bergen Commuter Rail', 'BJP', 'tefan cel Mare', 'Government of Texas', 'Democrat'], ['interior ministry', 'Brexit', 'Honolulu Government', 'Russia', 'United States'], ['Maurizio Bianchi', 'Democratic Party', 'RC Lens', 'RCD', 'UNESCO'], ['FC Dallas', 'Democratic Party', 'Democratic Party', 'England Saxons', 'University College London'], ['interior ministry', 'Argentine Primera B', 'Bangladesh Nationalist Party', 'interior ministry', 'UMP'], ['Democratic Party', 'interior ministry', 'Washington, D.C.', 'FC Porto', 'interior ministry'], ['Democratic Party of Japan', 'Ukraine', 'interior ministry', 'Bangladesh Nationalist Party', 'Serie A'], ['Democratic Party', 'Yokohama FC', 'University of South Korea', 'Democratic Party', 'Yuriy Kuzmin'], ['Thierry Henry', 'Conservative Party', 'UMP', 'England Saxons', 'Saudi Arabia'], ['Russia', 'England Saxons', 'Green Party of Norway', 'interior ministry', 'University of the Netherlands'], ['Jammu and Kashmir', 'Brexit', 'Hickory Newspapers LLC', 'France 5', 'United States of America'], ['University of the Netherlands', 'England Saxons', 'Bangladesh Nationalist Party', 'lvaro Uribe', "Darren O'Connor"], ['Democratic Party', 'ód University', 'Westfield Wheaton', 'Yves Saint Laurent', 'Maurizio Marchetti'], ['FC Barcelona', 'England and Wales', 'Democrat', 'United States Department of the Treasury', 'interior ministry'], ['Yokohama', 'France 5', 'Washington, D.C.', 'lvaro Cárdenas', 'University of Tehran'], ['Rio Tinto', 'François Mitterrand', 'UEFA', 'Mauricio Macri', "People's Party for Freedom and Democracy"], ['Argentine Primera B', 'Deputy Chief of Staff', 'MIT', 'Boxer TV', 'Charlotte Hornets LLC'], ['FC Barcelona', 'FC Sri Lanka', 'Argentine Primera B', 'Maurizio Cattaneo', 'New York City'], ['UMP', 'United States of America', 'interior ministry', 'CSKA Sofia', 'Yves Saint Laurent'], ['FC Porto', 'England and Wales', 'Darren McGrath', 'Bangladesh Nationalist Party', "People's Party for Freedom and Democracy"], ['interior ministry', 'FC Szczecin', 'University College London', 'England and Wales', 'Mayer'], ['Argentinos Juniors', 'Welsh Assembly', 'England and Wales', 'England and Wales', 'Boise City Council'], ['UNESCO', 'Washington, D.C.', 'Maurizio Cattaneo', "People's Party", 'Serbian Progressive Party'], ['FIA', 'FC Barcelona', 'France 3', 'France 5', 'FC Barcelona'], ['University of Virginia', 'United States of America', 'Regierungspräsident', 'interior ministry', 'FC Nantes'], ['interior ministry', 'interior ministry', 'interior ministry', 'UMP', 'Pau'], ['Yokohama FC', 'England & Wales', 'PEN International', 'England and Wales', 'Chartered Accountant'], ['Sahrawi Arab Democratic Republic', 'Labour Party', 'United States Department of Justice', 'Auckland City Council', 'France 5']]
Epoch 4: 100% 91/91 [00:09<00:00,  9.81it/s, loss=5.07, v_num=pqgq]
                                               [A
Epoch 4:   0% 0/91 [00:00<?, ?it/s, loss=5.07, v_num=pqgq]         
Epoch 5:   0% 0/91 [00:00<?, ?it/s, loss=5.07, v_num=pqgq]
Epoch 5:   1% 1/91 [00:00<00:41,  2.19it/s, loss=5.07, v_num=pqgq]
Epoch 5:   2% 2/91 [00:00<00:22,  3.98it/s, loss=5.07, v_num=pqgq]
Epoch 5:   3% 3/91 [00:00<00:17,  4.95it/s, loss=5.07, v_num=pqgq]
Epoch 5:   3% 3/91 [00:00<00:17,  4.95it/s, loss=4.9, v_num=pqgq] 
Epoch 5:   4% 4/91 [00:00<00:14,  6.12it/s, loss=4.9, v_num=pqgq]
Epoch 5:   5% 5/91 [00:00<00:12,  7.16it/s, loss=4.9, v_num=pqgq]
Epoch 5:   7% 6/91 [00:00<00:11,  7.56it/s, loss=4.9, v_num=pqgq]
Epoch 5:   7% 6/91 [00:00<00:11,  7.55it/s, loss=4.76, v_num=pqgq]
Epoch 5:   8% 7/91 [00:00<00:10,  8.30it/s, loss=4.76, v_num=pqgq]
Epoch 5:   9% 8/91 [00:00<00:09,  9.00it/s, loss=4.76, v_num=pqgq]
Epoch 5:  10% 9/91 [00:01<00:09,  8.63it/s, loss=4.76, v_num=pqgq]
Epoch 5:  10% 9/91 [00:01<00:09,  8.62it/s, loss=4.6, v_num=pqgq] 
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:41,  1.94it/s][A
Validating:   2% 2/82 [00:00<00:22,  3.63it/s][A
Epoch 5:  13% 12/91 [00:01<00:10,  7.18it/s, loss=4.6, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:15,  5.11it/s][A
Validating:   5% 4/82 [00:00<00:13,  5.86it/s][A
Epoch 5:  16% 15/91 [00:01<00:10,  7.50it/s, loss=4.6, v_num=pqgq]
Validating:   7% 6/82 [00:01<00:09,  7.79it/s][A
Validating:   9% 7/82 [00:01<00:09,  7.76it/s][A
Epoch 5:  20% 18/91 [00:02<00:09,  7.82it/s, loss=4.6, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:08,  9.05it/s][A
Validating:  13% 11/82 [00:01<00:07,  9.14it/s][A
Epoch 5:  23% 21/91 [00:02<00:08,  8.06it/s, loss=4.6, v_num=pqgq]
Validating:  16% 13/82 [00:01<00:07,  9.35it/s][A
Epoch 5:  26% 24/91 [00:02<00:08,  8.31it/s, loss=4.6, v_num=pqgq]
Validating:  18% 15/82 [00:01<00:06, 10.34it/s][A
Validating:  21% 17/82 [00:02<00:07,  9.07it/s][A
Epoch 5:  30% 27/91 [00:03<00:07,  8.33it/s, loss=4.6, v_num=pqgq]
Validating:  23% 19/82 [00:02<00:07,  8.98it/s][A
Epoch 5:  33% 30/91 [00:03<00:07,  8.42it/s, loss=4.6, v_num=pqgq]
Validating:  26% 21/82 [00:02<00:06,  8.93it/s][A
Validating:  27% 22/82 [00:02<00:06,  8.82it/s][A
Epoch 5:  36% 33/91 [00:03<00:06,  8.48it/s, loss=4.6, v_num=pqgq]
Validating:  29% 24/82 [00:02<00:06,  9.31it/s][A
Validating:  30% 25/82 [00:03<00:06,  8.96it/s][A
Epoch 5:  40% 36/91 [00:04<00:06,  8.51it/s, loss=4.6, v_num=pqgq]
Validating:  33% 27/82 [00:03<00:05,  9.37it/s][A
Validating:  34% 28/82 [00:03<00:05,  9.33it/s][A
Epoch 5:  43% 39/91 [00:04<00:06,  8.64it/s, loss=4.6, v_num=pqgq]
Validating:  37% 30/82 [00:03<00:04, 10.50it/s][A
Validating:  39% 32/82 [00:03<00:04, 10.41it/s][A
Epoch 5:  46% 42/91 [00:04<00:05,  8.78it/s, loss=4.6, v_num=pqgq]
Validating:  41% 34/82 [00:03<00:04,  9.78it/s][A
Epoch 5:  49% 45/91 [00:05<00:05,  8.86it/s, loss=4.6, v_num=pqgq]
Validating:  44% 36/82 [00:04<00:04, 10.28it/s][A
Validating:  46% 38/82 [00:04<00:04, 10.60it/s][A
Epoch 5:  53% 48/91 [00:05<00:04,  8.95it/s, loss=4.6, v_num=pqgq]
Validating:  49% 40/82 [00:04<00:03, 10.86it/s][A
Epoch 5:  56% 51/91 [00:05<00:04,  9.07it/s, loss=4.6, v_num=pqgq]
Validating:  51% 42/82 [00:04<00:03, 10.68it/s][A
Validating:  54% 44/82 [00:04<00:03,  9.97it/s][A
Epoch 5:  59% 54/91 [00:05<00:04,  9.06it/s, loss=4.6, v_num=pqgq]
Validating:  56% 46/82 [00:05<00:03,  9.14it/s][A
Epoch 5:  63% 57/91 [00:06<00:03,  9.03it/s, loss=4.6, v_num=pqgq]
Validating:  59% 48/82 [00:05<00:03,  8.90it/s][A
Validating:  60% 49/82 [00:05<00:03,  8.39it/s][A
Validating:  61% 50/82 [00:05<00:03,  8.54it/s][A
Epoch 5:  66% 60/91 [00:06<00:03,  8.93it/s, loss=4.6, v_num=pqgq]
Validating:  62% 51/82 [00:05<00:03,  8.52it/s][A
Validating:  63% 52/82 [00:05<00:03,  8.51it/s][A
Validating:  65% 53/82 [00:06<00:03,  8.49it/s][A
Epoch 5:  69% 63/91 [00:07<00:03,  8.90it/s, loss=4.6, v_num=pqgq]
Validating:  66% 54/82 [00:06<00:03,  8.44it/s][A
Validating:  68% 56/82 [00:06<00:02,  9.77it/s][A
Epoch 5:  73% 66/91 [00:07<00:02,  8.97it/s, loss=4.6, v_num=pqgq]
Validating:  70% 57/82 [00:06<00:02,  8.97it/s][A
Validating:  71% 58/82 [00:06<00:02,  8.63it/s][A
Validating:  72% 59/82 [00:06<00:02,  8.36it/s][A
Epoch 5:  76% 69/91 [00:07<00:02,  8.89it/s, loss=4.6, v_num=pqgq]
Validating:  73% 60/82 [00:06<00:02,  8.57it/s][A
Validating:  76% 62/82 [00:06<00:02,  9.67it/s][A
Epoch 5:  79% 72/91 [00:08<00:02,  8.95it/s, loss=4.6, v_num=pqgq]
Validating:  77% 63/82 [00:07<00:02,  9.34it/s][A
Validating:  79% 65/82 [00:07<00:01, 10.34it/s][A
Epoch 5:  82% 75/91 [00:08<00:01,  9.01it/s, loss=4.6, v_num=pqgq]
Validating:  82% 67/82 [00:07<00:01, 11.23it/s][A
Epoch 5:  86% 78/91 [00:08<00:01,  9.11it/s, loss=4.6, v_num=pqgq]
Validating:  84% 69/82 [00:07<00:01, 11.32it/s][A
Validating:  87% 71/82 [00:07<00:01, 10.94it/s][A
Epoch 5:  89% 81/91 [00:08<00:01,  9.16it/s, loss=4.6, v_num=pqgq]
Validating:  89% 73/82 [00:08<00:00, 10.50it/s][A
Epoch 5:  92% 84/91 [00:09<00:00,  9.17it/s, loss=4.6, v_num=pqgq]
Validating:  91% 75/82 [00:08<00:00, 10.22it/s][A
Validating:  94% 77/82 [00:08<00:00, 10.06it/s][A
Epoch 5:  96% 87/91 [00:09<00:00,  9.19it/s, loss=4.6, v_num=pqgq]
Validating:  96% 79/82 [00:08<00:00, 11.07it/s][A
Epoch 5:  99% 90/91 [00:09<00:00,  9.25it/s, loss=4.6, v_num=pqgq]
Validating:  99% 81/82 [00:08<00:00, 10.42it/s][A[['Stanford University', "People's Party for Freedom and Democracy", 'chief executive officer', 'Japan Green Party', 'University of Paris'], ['Denmark', 'chief executive officer', 'FC Barcelona B', 'Yuriy Kozlov', 'United States Senate'], ['Société Générale', 'France 3', 'Turkey', 'Yuriy Kozlov', 'FC Barcelona'], ['Germany', "People's Deputy of Finland", "People's Party for Freedom and Democracy", 'interior ministry', "People's Party for Freedom and Democracy"], ['United States Department of Justice', 'Eurostar', 'chief executive officer', 'FC Dallas', 'Stanford University'], ['Drottningholm', 'FC Nantes', 'The New York Times', 'United Kingdom', 'Max Planck Society'], ['FC Dallas', 'st st', 'FC Dallas', 'Bangladesh Nationalist Party', 'France 3'], ['The New York Times', 'Stanford University', 'The New York Times', 'United States Department of Education', 'Darren Fletcher'], ['The New York Times', 'Member of the Philippines', 'U.S. Airways', 'FC Barcelona', 'S.L. Kerala'], ['FC Barcelona', "People's Television Network", 'Yokohama FC', 'Ukraine', 'Wells Fargo'], ['chief executive officer', 'FEMA', 'chief executive officer', "People's Deputy of Singapore", "People's Deputy of Norway"], ['FC Dallas', 'France 5', 'United States Department of State', 'FC Barcelona', 'Stanford University'], ['France 3', 'The People of Freedom', 'FC Milan', 'S.L. Benfica', 'FC Dallas'], ['France 3', 'Pennsylvania State Senate', "Sainsbury's", 'France 5', 'Cristiano Ronaldo'], ['Malaysian Green Party', 'FC Barcelona', 'India Today', 'Netscape', 'Cristiano Ronaldo'], ['chief executive officer', "People's Deputy of Poland", 'United States Department of State', 'United States of America', 'FC Barcelona'], ['FC Dallas', 'FC Nürnberg', 'FC Nantes', "People's Party for Freedom and Democracy", 'Maya Angelou'], ['chief executive officer', 'chief executive officer', 'Poland', 'FC Barcelona', 'Silvio Berlusconi'], ['Democratic Party', "People's Party for Freedom and Democracy", 'FIFA', "People's Deputy of Turkey", 'Christian Democratic Union'], ['North Carolina State University', 'Democratic Party', 'France 3', 'The People of Freedom', 'FC Barcelona'], ['executive Electoral Commissioner', 'China National Petroleum Corporation', 'Ferrovie dello Stato Italiane', 'FC Barcelona', 'Czechoslovakia'], ['United States Department of Education', 'European Commission', 'Cristian Castro', "People's Deputy of Denmark", 'Juventus'], ['FC Barcelona', 'FC Twente', 'The New York Times', 'United Kingdom', 'Germany'], ['United Kingdom', 'FC Barcelona', 'Grupo Panamericano', 'Björn Borg', 'FC Barcelona'], ["People's Party for Freedom and Democracy", 'UNESCO', 'Democratic Party', 'Greece', 'Televisa'], ['chief executive officer', 'FC Dallas', 'Nicolás Maduro', 'The People of Freedom', 'FC Dallas'], ['Telefónica de Chile', 'chief executive officer', 'FC Dallas', 'Finland', "Christian Social People's Party"], ['United States Department of Energy', 'Microsoft', "People's Deputy of China", 'The Nature Conservancy', 'NBCUniversal'], ['The New York Times', 'Cristian Dulca', 'France 3', 'Russia', 'FC Dallas'], ['Kyto', 'FC Dallas', 'FC Dallas', 'FC Barcelona', 'chief executive officer'], ['FC Dallas', 'FC Nantes', 'The New York Times', 'chief executive officer', 'The New York Times'], ["People's Party for Freedom and Democracy", 'Barangay Ginebra', 'Russia', 'of Spain', 'France 3'], ['The People of Freedom', 'Sweden', 'FC Dallas', 'Yuriy Kozlov', 'United States of America'], ['Member of Parliament', "People's Deputy of the Philippines", 'Nicolaus Copernicus', 'FC Barcelona', 'Cristiano Ronaldo'], ['FC Barcelona B', 'Ukraine', 'France 2', 'Democratic Party', 'Stanford University'], ['independent independent', 'Jeremy Corbyn', 'chief executive officer', "People's Deputy of Russia", 'So Paulo'], ['So Paulo', 'Democratic Progressive Party', 'Parliament of Sri Lanka', 'FC Dallas', 'United States Air Force'], ['National Portrait Gallery', 'The People of Freedom', 'FC Barcelona B', 'FC Barcelona', 'Kongregate'], ['FC Barcelona', 'The New York Times', 'Washington, D.C.', 'Germany', 'France 3'], ['United States Representative', 'The People of Freedom', 'Qatar', 'interior ministry', 'independent chief executive officer'], ['The New York Times', 'The People of Freedom', 'Romanian National Party', 'The People of Freedom', 'So Paulo'], ['FC Barcelona', 'France 3', "European People's Party", 'Liaoning City Council', 'Tribune Media'], ['Yuriy Ivanovich Ivanov', "People's Party for Freedom and Democracy", 'FC Dallas', 'FC Porto', 'chief executive officer'], ['France 5', 'chief executive officer', 'chief executive officer', 'Al Jazeera English', 'Romanian National Party'], ['United States Department of Justice', 'France 3', 'eljko orevi', "People's Party for Freedom and Democracy", 'independent independent'], ['Changhua County', 'Entercom', 'Jeremy Corbyn', 'FC Dallas', 'United States of America'], ['Buenos Aires', 'Aaron Johnson', 'The New York Times', 'The New York Times', 'The New York Times'], ['University of Tokyo', 'The Greens', "People's Deputy of Venezuela", 'France 3', "People's Party for Freedom and Democracy"], ['University of Lagos', "Pakistan People's Party", 'ukasz Kocielny', 'executive executive executive officer', 'FC Dallas'], ['chief executive officer', '', 'S.L. Benfica', 'chief executive officer', 'Vice-Chancellor of the Philippines'], ['FC Dallas', 'FC Barcelona', 'Emmanuel Macron', 'chief executive officer', "People's Deputy of Finland"], ['Democratic Party', 'FC Barcelona', 'The New York Times', 'chief executive officer', "People's Deputy of Colombia"], ["People's Deputy of Venezuela", 'FC Barcelona', 'Lithuanian National Assembly', 'FC Barcelona', 'England and Wales'], ['chief executive officer', 'United Kingdom', 'S.L. Benfica', 'Tamil Nadu Legislative Assembly', 'The New York Times'], ['Bergen County', 'India Today', 'Romanian Football Federation', 'Texas State Legislature', 'chief executive officer'], ['chief executive officer', 'The New York Times', 'Hawaii', 'Russia', 'The People of Freedom'], ['Mauritz Schröder', 'The People of Freedom', 'FC Nantes', 'lvaro Cárdenas', 'Armenian National Committee'], ['FC Dallas', "People's Party for Freedom and Democracy", 'The People of Freedom', 'FC Dallas', 'Stanford University'], ['chief executive officer', 'FC Barcelona', "People's Party for Freedom and Democracy", 'chief executive officer', 'Union for a Popular Movement'], ["Romanian People's Party", 'chief executive officer', 'Washington, D.C.', 'FC Porto', 'chief executive officer'], ['Democratic Party', 'Ukraine', 'chief executive officer', 'Bangladesh Nationalist Party', 'FC Milan'], ['The People of Freedom', 'FC Barcelona', 'University of South Korea', 'The People of Freedom', 'Nicolás Almagro'], ['Thierry Henry', 'Democratic Party', 'Socialist Party', 'FC Dallas', 'S.L. Saadiq'], ['Russia', 'FC Dallas', 'Green Party of Norway', 'UMNO', 'University of Amsterdam'], ['BJP', 'The New York Times', 'Hickory Newspapers', 'France 5', 'The New York Times'], ['Stanford University', 'FC Dallas', 'Bangladesh Nationalist Party', 'Andreas Weiss', "Sean O'Connor"], ['Democratic Party', 'University of Minnesota', 'Westfield Wheaton', 'Germany', 'Milan'], ['FC Barcelona', 'FC Dallas', 'executive Electoral College', 'United States Steel Corporation', 'chief executive officer'], ['Yokohama FC', 'France 3', 'The New York Times', 'Cristian Castro', 'University of Tehran'], ['Rio Tinto', 'France 2', 'Germany', 'Nicolas Marais', "People's Action Party"], ['FC Barcelona', 'Vice-Chancellor of the Philippines', 'Stanford University', 'Boxer TV', 'Charlotte Hornets'], ['FC Barcelona', 'S.L. Sabah', 'FC Barcelona', 'Silvio Berlusconi', 'Judith A. Smith'], ["European People's Party", 'The New York Times', 'executive officer of Ireland', 'FC Ararat', 'France 3'], ['FC Barcelona', 'FC Porto', 'Christian McKinley', 'Bangladesh Nationalist Party', 'Yuriy Zhukov'], ['chief executive officer', 'FC Szczecin', 'Stanford University', 'United States Air Force', 'The New York Times'], ['FC Barcelona', 'Wales', 'FC Dallas', 'Australia', 'Boise City Council'], ['UNESCO', 'Washington, D.C.', 'Silvio Berlusconi', "People's Party for Freedom and Democracy", 'Democratic Party'], ['Ferrari', 'FC Barcelona', 'France 3', 'France 5', 'FC Barcelona'], ['Stanford University', 'The New York Times', 'Germany', 'chief executive officer', 'FC Nantes'], ['chief executive officer', "People's Deputy of Denmark", 'chief executive officer', "People's Party for Freedom and Democracy", 'Pau'], ['Yokohama FC', 'England and Wales', 'PEN International', 'FC Seoul', 'chief executive officer'], ['Sahrawi Arab Democratic Republic', 'The People of Freedom', 'The New York Times', 'Auckland City Council', 'France 5']]
Epoch 5: 100% 91/91 [00:09<00:00,  9.11it/s, loss=4.6, v_num=pqgq]
                                               [A
Epoch 5:   0% 0/91 [00:00<?, ?it/s, loss=4.6, v_num=pqgq]         
Epoch 6:   0% 0/91 [00:00<?, ?it/s, loss=4.6, v_num=pqgq]
Epoch 6:   1% 1/91 [00:00<00:39,  2.27it/s, loss=4.6, v_num=pqgq]
Epoch 6:   2% 2/91 [00:00<00:21,  4.06it/s, loss=4.6, v_num=pqgq]
Epoch 6:   3% 3/91 [00:00<00:17,  5.08it/s, loss=4.6, v_num=pqgq]
Epoch 6:   3% 3/91 [00:00<00:17,  5.08it/s, loss=4.43, v_num=pqgq]
Epoch 6:   4% 4/91 [00:00<00:13,  6.28it/s, loss=4.43, v_num=pqgq]
Epoch 6:   5% 5/91 [00:00<00:11,  7.32it/s, loss=4.43, v_num=pqgq]
Epoch 6:   7% 6/91 [00:00<00:11,  7.67it/s, loss=4.43, v_num=pqgq]
Epoch 6:   7% 6/91 [00:00<00:11,  7.67it/s, loss=4.28, v_num=pqgq]
Epoch 6:   8% 7/91 [00:00<00:09,  8.45it/s, loss=4.28, v_num=pqgq]
Epoch 6:   9% 8/91 [00:00<00:09,  9.16it/s, loss=4.28, v_num=pqgq]
Epoch 6:  10% 9/91 [00:01<00:09,  8.76it/s, loss=4.28, v_num=pqgq]
Epoch 6:  10% 9/91 [00:01<00:09,  8.75it/s, loss=4.01, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:41,  1.96it/s][A
Validating:   2% 2/82 [00:00<00:23,  3.40it/s][A
Epoch 6:  13% 12/91 [00:01<00:11,  7.12it/s, loss=4.01, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:17,  4.57it/s][A
Validating:   5% 4/82 [00:00<00:14,  5.22it/s][A
Validating:   6% 5/82 [00:01<00:14,  5.23it/s][A
Epoch 6:  16% 15/91 [00:02<00:10,  6.96it/s, loss=4.01, v_num=pqgq]
Validating:   9% 7/82 [00:01<00:11,  6.50it/s][A
Epoch 6:  20% 18/91 [00:02<00:10,  7.23it/s, loss=4.01, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:10,  7.20it/s][A
Validating:  12% 10/82 [00:01<00:09,  7.44it/s][A
Validating:  13% 11/82 [00:01<00:11,  6.11it/s][A
Epoch 6:  23% 21/91 [00:02<00:09,  7.00it/s, loss=4.01, v_num=pqgq]
Validating:  15% 12/82 [00:02<00:10,  6.57it/s][A
Validating:  16% 13/82 [00:02<00:10,  6.70it/s][A
Epoch 6:  26% 24/91 [00:03<00:09,  7.22it/s, loss=4.01, v_num=pqgq]
Validating:  18% 15/82 [00:02<00:07,  8.50it/s][A
Validating:  21% 17/82 [00:02<00:07,  8.73it/s][A
Epoch 6:  30% 27/91 [00:03<00:08,  7.43it/s, loss=4.01, v_num=pqgq]
Validating:  22% 18/82 [00:02<00:09,  6.79it/s][A
Validating:  23% 19/82 [00:03<00:09,  6.87it/s][A
Validating:  24% 20/82 [00:03<00:08,  7.19it/s][A
Epoch 6:  33% 30/91 [00:04<00:08,  7.21it/s, loss=4.01, v_num=pqgq]
Validating:  26% 21/82 [00:03<00:10,  6.07it/s][A
Validating:  27% 22/82 [00:03<00:09,  6.35it/s][A
Validating:  28% 23/82 [00:03<00:08,  6.79it/s][A
Epoch 6:  36% 33/91 [00:04<00:08,  7.09it/s, loss=4.01, v_num=pqgq]
Validating:  29% 24/82 [00:03<00:08,  6.87it/s][A
Validating:  32% 26/82 [00:03<00:07,  7.85it/s][A
Epoch 6:  40% 36/91 [00:05<00:07,  7.19it/s, loss=4.01, v_num=pqgq]
Validating:  33% 27/82 [00:04<00:07,  7.37it/s][A
Validating:  34% 28/82 [00:04<00:06,  7.75it/s][A
Validating:  35% 29/82 [00:04<00:07,  7.55it/s][A
Epoch 6:  43% 39/91 [00:05<00:07,  7.20it/s, loss=4.01, v_num=pqgq]
Validating:  37% 30/82 [00:04<00:07,  7.23it/s][A
Validating:  38% 31/82 [00:04<00:06,  7.52it/s][A
Epoch 6:  46% 42/91 [00:05<00:06,  7.27it/s, loss=4.01, v_num=pqgq]
Validating:  40% 33/82 [00:04<00:05,  8.49it/s][A
Validating:  41% 34/82 [00:04<00:05,  8.26it/s][A
Epoch 6:  49% 45/91 [00:06<00:06,  7.37it/s, loss=4.01, v_num=pqgq]
Validating:  44% 36/82 [00:05<00:06,  6.84it/s][A
Validating:  45% 37/82 [00:05<00:06,  6.99it/s][A
Validating:  46% 38/82 [00:05<00:06,  7.23it/s][A
Epoch 6:  53% 48/91 [00:06<00:05,  7.23it/s, loss=4.01, v_num=pqgq]
Validating:  48% 39/82 [00:05<00:05,  7.29it/s][A
Validating:  49% 40/82 [00:06<00:07,  5.83it/s][A
Validating:  50% 41/82 [00:06<00:06,  6.12it/s][A
Epoch 6:  56% 51/91 [00:07<00:05,  7.10it/s, loss=4.01, v_num=pqgq]
Validating:  51% 42/82 [00:06<00:06,  6.64it/s][A
Validating:  52% 43/82 [00:06<00:05,  7.05it/s][A
Validating:  54% 44/82 [00:06<00:06,  6.25it/s][A
Epoch 6:  59% 54/91 [00:07<00:05,  7.08it/s, loss=4.01, v_num=pqgq]
Validating:  55% 45/82 [00:06<00:05,  6.44it/s][A
Validating:  56% 46/82 [00:06<00:05,  6.93it/s][A
Epoch 6:  63% 57/91 [00:07<00:04,  7.14it/s, loss=4.01, v_num=pqgq]
Validating:  59% 48/82 [00:07<00:04,  7.97it/s][A
Validating:  60% 49/82 [00:07<00:04,  8.21it/s][A
Validating:  61% 50/82 [00:07<00:04,  7.27it/s][A
Epoch 6:  66% 60/91 [00:08<00:04,  7.15it/s, loss=4.01, v_num=pqgq]
Validating:  62% 51/82 [00:07<00:05,  5.81it/s][A
Validating:  63% 52/82 [00:07<00:05,  5.03it/s][A
Validating:  65% 53/82 [00:07<00:05,  5.78it/s][A
Epoch 6:  69% 63/91 [00:09<00:04,  6.98it/s, loss=4.01, v_num=pqgq]
Validating:  66% 54/82 [00:08<00:04,  6.47it/s][A
Validating:  67% 55/82 [00:08<00:04,  5.86it/s][A
Validating:  68% 56/82 [00:08<00:05,  5.04it/s][A
Epoch 6:  73% 66/91 [00:09<00:03,  6.87it/s, loss=4.01, v_num=pqgq]
Validating:  71% 58/82 [00:08<00:03,  6.36it/s][A
Validating:  72% 59/82 [00:09<00:04,  5.45it/s][A
Epoch 6:  76% 69/91 [00:10<00:03,  6.84it/s, loss=4.01, v_num=pqgq]
Validating:  73% 60/82 [00:09<00:03,  5.80it/s][A
Validating:  74% 61/82 [00:09<00:03,  6.16it/s][A
Validating:  76% 62/82 [00:09<00:03,  6.62it/s][A
Epoch 6:  79% 72/91 [00:10<00:02,  6.86it/s, loss=4.01, v_num=pqgq]
Validating:  77% 63/82 [00:09<00:02,  7.01it/s][A
Validating:  78% 64/82 [00:09<00:02,  7.35it/s][A
Epoch 6:  82% 75/91 [00:10<00:02,  6.92it/s, loss=4.01, v_num=pqgq]
Validating:  80% 66/82 [00:09<00:01,  8.06it/s][A
Validating:  82% 67/82 [00:10<00:01,  7.79it/s][A
Validating:  83% 68/82 [00:10<00:01,  7.18it/s][A
Epoch 6:  86% 78/91 [00:11<00:01,  6.92it/s, loss=4.01, v_num=pqgq]
Validating:  85% 70/82 [00:10<00:01,  8.51it/s][A
Validating:  87% 71/82 [00:10<00:01,  8.48it/s][A
Epoch 6:  89% 81/91 [00:11<00:01,  7.01it/s, loss=4.01, v_num=pqgq]
Validating:  88% 72/82 [00:10<00:01,  8.41it/s][A
Validating:  89% 73/82 [00:10<00:01,  8.58it/s][A
Epoch 6:  92% 84/91 [00:11<00:00,  7.07it/s, loss=4.01, v_num=pqgq]
Validating:  91% 75/82 [00:10<00:00,  8.64it/s][A
Validating:  93% 76/82 [00:11<00:00,  8.61it/s][A
Epoch 6:  96% 87/91 [00:12<00:00,  7.11it/s, loss=4.01, v_num=pqgq]
Validating:  95% 78/82 [00:11<00:00,  9.37it/s][A
Validating:  96% 79/82 [00:11<00:00,  8.60it/s][A
Validating:  98% 80/82 [00:11<00:00,  6.58it/s][A
Epoch 6:  99% 90/91 [00:12<00:00,  7.07it/s, loss=4.01, v_num=pqgq]
Validating:  99% 81/82 [00:11<00:00,  6.31it/s][A[['Stanford University', 'The People of Freedom', 'interior ministry', 'Democratic Party', 'France 5'], ['', 'Vice-President of the Navy', 'S.L. Benfica', '', 'United States of America'], ['S.L. Benfica', 'France 5', 'ahin', 'Yuriy Davydenko', 'Valencia CF'], ['', 'Vice-President of Finland', "People's Party", "the People's Deputy of Hungary", "The People's Party for Freedom and Democracy"], ['The New York Times', 'Eurostar', 'in the House of Representatives', 'Birmingham City F.C.', 'Stanford University'], ['', 'Paris Saint-Germain', 'The New York Times', 'United States of America', ''], ['Birmingham City F.C.', 'Yuriy Davydenko', 'Birmingham City F.C.', 'Bangladesh Awami League', 'United States of America'], ['The New York Times', 'Stanford University', 'The New York Times', 'United States Senate', 'Cristiano Ronaldo'], ['The New York Times', 'politician', 'Michael Bloomberg', 'Valencia CF', 'S.L. Benfica'], ['IF Elfsborg', 'Weibo', 'Birmingham City F.C.', '', 'Wells Fargo'], ['', '', '', 'chief executive officer', 'Vice-President of Norway'], ['Birmingham City F.C.', 'France 5', 'United States Senate', 'S.L. Benfica', 'Stanford University'], ['S.L.A.', 'The People of Freedom', 'S.L. Benfica', 'S.L. Milan', 'Birmingham City F.C.'], ['Germany', 'Pennsylvania State Senate', 'David Cameron', 'France 5', ''], ['Malaysian Greens', 'Valencia CF', 'United Arab Emirates', 'Netscape Communications', 'Cristiano Ronaldo'], ['interior ministry', 'of Poland', 'United States Senate', 'United Kingdom', 'Al Jazeera English'], ['Birmingham City F.C.', 'S.L. Benfica', 'Paris Saint-Germain', 'France 5', 'David Cameron'], ['Vice-President of the European Commission', '', 'Poland', 'Beerschot AC', 'Silvio Berlusconi'], ['Democratic Convergence of Catalonia', 'The People of Freedom', '', '', 'The People of Freedom'], ['North Carolina State University', 'Democratic Party', 'United States of America', 'United States of America', 'S.L. Benfica'], ['Vice-President of the European Commission', 'The People of Freedom', 'Ferrovie dello Stato Italiane', 'Birmingham City F.C.', ''], ['United States Department of Education', 'France 5', 'Cristiano Ronaldo', 'interior ministry', 'Silvio Berlusconi'], ['S.L. Benfica', 'S.L. Benfica', 'The New York Times', 'United States Senate', 'France 5'], ['United States of America', 'Birmingham City F.C.', 'Grupo Panamericano', '', 'S.L. Benfica'], ['The People of Freedom', 'The Walt Disney Company', 'The People of Freedom', 'online', 'Televisa'], ['interior ministry', 'Birmingham City F.C.', 'Nicolás Maduro', 'The People of Freedom', 'S.L. Benfica'], ['Ofcom', 'Vice-President of the World', 'Birmingham City F.C.', 'Finland', 'France 5'], ['United States of America', '.com', 'chief executive officer', 'The Coca-Cola Company', 'The Coca-Cola Company'], ['The New York Times', 'Cristian Dulca', 'United States of America', 'Yuriy Davydenko', 'Birmingham City F.C.'], ['Shinzo Abe', 'S.L. Benfica', 'Birmingham City F.C.', 'Valencia CF', 'Vice-President of the European Commission'], ['Birmingham City F.C.', 'Paris Saint-Germain', 'The New York Times', 'interior ministry', 'United States Senate'], ['The People of Freedom', 'Carlos Menem', 'Russia', 'The People of Freedom', 'France 5'], ['United States Senate', 'United States of America', 'Birmingham City F.C.', 'Yves Saint Laurent', 'United States of America'], ['interior ministry', 'of New York City', 'Germany', 'S.L. Benfica', 'Cristian Castro'], ['S.L. Milan', '', 'France 5', 'Democratic Union', 'Stanford University'], ['', 'France 5', '', 'Ukraine', 'S. Paulo'], ['S. Paulo', 'Democratic Party', 'Parliament of India', 'Birmingham City F.C.', 'United States of America'], ['University of Virginia', 'The People of Freedom', 'Birmingham City F.C.', 'S.L. Benfica', 'Kongregat'], ['S.L. Benfica', 'United States Senate', 'United States Department of Justice', 'S.L. Benfica', 'FIA'], ['United States Attorney', 'The People of Freedom', 'Qatari Government', 'of Serbia', ''], ['United States Department of Education', 'The People of Freedom', 'Democratic Convergence of Catalonia', 'The People of Freedom', 'Sérgio Mendes'], ['Birmingham City F.C.', 'France 5', 'France 5', 'Liaoning', 'Los Angeles Times'], ['Yuriy Ivanov', 'The People of Freedom', 'Birmingham City F.C.', 'Benfica', 'interior ministry'], ['France 5', 'Vice-President of the Philippines', 'Vice-President of the European Commission', 'Al-Ahly', 'Democratic Union'], ['United States Department of Justice', 'France 5', 'Yuriy Yuriyev', 'The People of Freedom', 'Vice-President of the Navy'], ['Changhua County', 'Entercom', 'David Cameron', 'Birmingham City F.C.', 'United States of America'], ['France 5', 'Ben Hodges', 'United States of America', 'The New York Times', 'United States of America'], ['University of Tokyo', "People's Party", 'in Canada', 'France 5', 'The People of Freedom'], ['University of Otago', 'Bangladesh Awami League', 'Mariusz Fyrstenberg', 'Democrat', 'Birmingham City F.C.'], ['United States Attorney', 'ONO', 'Birmingham City F.C.', 'Vice-President of the Navy', 'Vice-President of the Philippines'], ['Birmingham City F.C.', 'SK Rapid Wien', 'France 5', 'interior ministry', ''], ["Democratic Workers' Party", 'United States of America', 'Los Angeles Angels', '', 'Vice-President of the Philippines'], ['of the Philippines', 'Toronto Raptors', 'Lithuanian Parliament', 'Toronto Raptors', 'England and Wales Cricket Board'], ['interior ministry', 'United Kingdom', 'S.L. Saab', '', 'United States Department of Education'], ['Norges Statsbaner', 'United Arab Emirates', 'Romania', 'Carlos Menem', ''], ['', 'United States Senate', 'Honolulu', 'Russia Today', 'United States of America'], ['Christian Schäfer', 'The People of Freedom', 'RC Lens', 'Carlos Menem', 'United States of America'], ['Birmingham City F.C.', 'The People of Freedom', 'The People of Freedom', 'Birmingham City F.C.', 'Stanford University'], ['', 'Valencia CF', 'United States Senate', '', 'France 5'], ['Democratic Convergence of Catalonia', 'interior ministry', 'The New York Times', 'Benfica', ''], ['Democratic Party', 'Football League', 'interior ministry', 'Bangladesh Awami League', 'Benfica'], ['The People of Freedom', 'S.L. Benfica', 'University of South Korea', 'The People of Freedom', 'Cristian Dulca'], ['', 'The People of Freedom', 'France 5', 'Birmingham City F.C.', 'S.L. Benfica'], ['Russia', 'Birmingham City F.C.', '', 'S.L. Benfica', 'Stanford University'], ['', 'United States Senate', 'Hickory Newspapers', 'The People of Freedom', 'The New York Times'], ['Stanford University', 'Birmingham City F.C.', 'Bangladesh Awami League', 'Christian X', 'UCD'], ['Democratic Convergence of Catalonia', 'Stanford University', 'Wheaton, Inc.', 'France 5', 'Silvio Berlusconi'], ['Valencia CF', 'Toronto Raptors', 'Vice-President of the Philippines', 'United States Steel Corporation', 'interior ministry'], ['The People of Freedom', 'France 5', 'The New York Times', 'Cristian Dulca', 'Istanbul University'], ['Benfica', 'France 5', 'Germany', '', 'The People of Freedom'], ['Valencia CF', 'of New York City', 'Stanford University', 'Boxer TV', 'Charlotte Hornets'], ['Barcelona B', 'S.L. Benfica', 'S.L. Benfica', 'Francesco Sforza', 'Michael C. Smith'], ['France 5', 'United States Department of State', 'Teachta Dála', 'France 5', 'United States of America'], ['Valencia CF', 'Toronto Raptors', 'Mike Wallace', 'Bangladesh Awami League', ''], ['Vice-President of India', 'Wolverhampton Wanderers', 'Stanford University', 'England and Wales Cricket Board', 'United States of America'], ['Valencia CF', 'Wales', 'Toronto Raptors', 'Birmingham City F.C.', ''], ['The People of Freedom', 'The New York Times', 'Silvio Berlusconi', 'The People of Freedom', 'Democratic Party'], ['Vicenza', 'Valencia CF', 'France 5', 'Vicenza', 'Valencia CF'], ['Stanford University', 'Toronto Raptors', 'Germany', 'Vice-President of the European Commission', 'Olympique Lyonnais'], ['', 'interior ministry', 'chief executive officer', 'France 5', 'France 5'], ['S.L. Benfica', 'England and Wales Cricket Board', 'PEN', 'Toronto Raptors', 'interior ministry'], ['', 'The People of Freedom', 'The New York Times', '', 'Vicenza']]
Epoch 6: 100% 91/91 [00:13<00:00,  6.97it/s, loss=4.01, v_num=pqgq]
                                               [A
Epoch 6:   0% 0/91 [00:00<?, ?it/s, loss=4.01, v_num=pqgq]         
Epoch 7:   0% 0/91 [00:00<?, ?it/s, loss=4.01, v_num=pqgq]
Epoch 7:   1% 1/91 [00:00<00:39,  2.25it/s, loss=4.01, v_num=pqgq]
Epoch 7:   2% 2/91 [00:00<00:22,  4.04it/s, loss=4.01, v_num=pqgq]
Epoch 7:   3% 3/91 [00:00<00:17,  5.06it/s, loss=4.01, v_num=pqgq]
Epoch 7:   3% 3/91 [00:00<00:17,  5.05it/s, loss=3.75, v_num=pqgq]
Epoch 7:   4% 4/91 [00:00<00:13,  6.25it/s, loss=3.75, v_num=pqgq]
Epoch 7:   5% 5/91 [00:00<00:11,  7.30it/s, loss=3.75, v_num=pqgq]
Epoch 7:   7% 6/91 [00:00<00:11,  7.67it/s, loss=3.75, v_num=pqgq]
Epoch 7:   7% 6/91 [00:00<00:11,  7.66it/s, loss=3.43, v_num=pqgq]
Epoch 7:   8% 7/91 [00:00<00:09,  8.42it/s, loss=3.43, v_num=pqgq]
Epoch 7:   9% 8/91 [00:00<00:09,  9.13it/s, loss=3.43, v_num=pqgq]
Epoch 7:  10% 9/91 [00:01<00:09,  8.71it/s, loss=3.43, v_num=pqgq]
Epoch 7:  10% 9/91 [00:01<00:09,  8.70it/s, loss=3.16, v_num=pqgq]
Validating: 0it [00:00, ?it/s][A
Validating:   0% 0/82 [00:00<?, ?it/s][A
Validating:   1% 1/82 [00:00<00:47,  1.71it/s][A
Validating:   2% 2/82 [00:00<00:25,  3.18it/s][A
Epoch 7:  13% 12/91 [00:01<00:11,  6.86it/s, loss=3.16, v_num=pqgq]
Validating:   4% 3/82 [00:00<00:18,  4.32it/s][A
Validating:   5% 4/82 [00:00<00:15,  5.05it/s][A
Validating:   6% 5/82 [00:01<00:13,  5.90it/s][A
Epoch 7:  16% 15/91 [00:02<00:10,  6.98it/s, loss=3.16, v_num=pqgq]
Validating:   7% 6/82 [00:01<00:11,  6.55it/s][A
Validating:   9% 7/82 [00:01<00:10,  7.24it/s][A
Validating:  10% 8/82 [00:01<00:09,  7.91it/s][A
Epoch 7:  20% 18/91 [00:02<00:10,  7.27it/s, loss=3.16, v_num=pqgq]
Validating:  11% 9/82 [00:01<00:09,  7.45it/s][A
Validating:  12% 10/82 [00:01<00:09,  7.53it/s][A
Validating:  13% 11/82 [00:01<00:09,  7.74it/s][A
Epoch 7:  23% 21/91 [00:02<00:09,  7.29it/s, loss=3.16, v_num=pqgq]
Validating:  15% 12/82 [00:01<00:08,  7.89it/s][A
Validating:  16% 13/82 [00:02<00:08,  7.83it/s][A
Validating:  17% 14/82 [00:02<00:08,  7.81it/s][A
Epoch 7:  26% 24/91 [00:03<00:09,  7.36it/s, loss=3.16, v_num=pqgq]
Validating:  20% 16/82 [00:02<00:07,  8.32it/s][A
Validating:  21% 17/82 [00:02<00:08,  8.12it/s][A
Epoch 7:  30% 27/91 [00:03<00:08,  7.47it/s, loss=3.16, v_num=pqgq]
Validating:  22% 18/82 [00:02<00:07,  8.35it/s][A
Validating:  23% 19/82 [00:02<00:07,  7.93it/s][A
Epoch 7:  33% 30/91 [00:03<00:08,  7.57it/s, loss=3.16, v_num=pqgq]
Validating:  26% 21/82 [00:03<00:08,  7.37it/s][A
Validating:  27% 22/82 [00:03<00:08,  7.28it/s][A
Validating:  28% 23/82 [00:03<00:07,  7.51it/s][A
Epoch 7:  36% 33/91 [00:04<00:07,  7.46it/s, loss=3.16, v_num=pqgq]
Validating:  29% 24/82 [00:03<00:07,  7.66it/s][A
Validating:  30% 25/82 [00:03<00:07,  7.47it/s][A
Validating:  32% 26/82 [00:03<00:07,  7.67it/s][A
Epoch 7:  40% 36/91 [00:04<00:07,  7.48it/s, loss=3.16, v_num=pqgq]
Validating:  33% 27/82 [00:03<00:06,  8.03it/s][A
Validating:  34% 28/82 [00:03<00:06,  8.27it/s][A
Epoch 7:  43% 39/91 [00:05<00:06,  7.59it/s, loss=3.16, v_num=pqgq]
Validating:  37% 30/82 [00:04<00:06,  8.62it/s][A
Validating:  38% 31/82 [00:04<00:05,  8.73it/s][A
Validating:  39% 32/82 [00:04<00:06,  8.17it/s][A
Epoch 7:  46% 42/91 [00:05<00:06,  7.62it/s, loss=3.16, v_num=pqgq]
Validating:  40% 33/82 [00:04<00:05,  8.18it/s][A
Validating:  41% 34/82 [00:04<00:05,  8.03it/s][A
Validating:  43% 35/82 [00:04<00:05,  8.34it/s][A
Epoch 7:  49% 45/91 [00:05<00:06,  7.66it/s, loss=3.16, v_num=pqgq]
Validating:  44% 36/82 [00:04<00:05,  8.13it/s][A
Validating:  45% 37/82 [00:05<00:05,  8.40it/s][A
Validating:  46% 38/82 [00:05<00:05,  7.71it/s][A
Epoch 7:  53% 48/91 [00:06<00:05,  7.66it/s, loss=3.16, v_num=pqgq]
Validating:  48% 39/82 [00:05<00:05,  7.68it/s][A
Validating:  49% 40/82 [00:05<00:05,  7.27it/s][A
Validating:  50% 41/82 [00:05<00:05,  7.38it/s][A
Epoch 7:  56% 51/91 [00:06<00:05,  7.63it/s, loss=3.16, v_num=pqgq]
Validating:  51% 42/82 [00:05<00:05,  7.29it/s][A
Validating:  52% 43/82 [00:05<00:05,  7.18it/s][A
Validating:  54% 44/82 [00:06<00:05,  7.26it/s][A
Epoch 7:  59% 54/91 [00:07<00:04,  7.60it/s, loss=3.16, v_num=pqgq]
Validating:  55% 45/82 [00:06<00:05,  7.14it/s][A
Validating:  57% 47/82 [00:06<00:04,  8.10it/s][A
Epoch 7:  63% 57/91 [00:07<00:04,  7.64it/s, loss=3.16, v_num=pqgq]
Validating:  59% 48/82 [00:06<00:04,  7.80it/s][A
Validating:  60% 49/82 [00:06<00:04,  7.78it/s][A
Validating:  61% 50/82 [00:06<00:04,  7.72it/s][A
Epoch 7:  66% 60/91 [00:07<00:04,  7.63it/s, loss=3.16, v_num=pqgq]
Validating:  62% 51/82 [00:06<00:04,  7.66it/s][A
Validating:  63% 52/82 [00:07<00:03,  7.62it/s][A
Validating:  65% 53/82 [00:07<00:03,  7.80it/s][A
Epoch 7:  69% 63/91 [00:08<00:03,  7.64it/s, loss=3.16, v_num=pqgq]
Validating:  66% 54/82 [00:07<00:03,  7.94it/s][A
Validating:  67% 55/82 [00:07<00:03,  8.26it/s][A
Validating:  68% 56/82 [00:07<00:03,  8.30it/s][A
Epoch 7:  73% 66/91 [00:08<00:03,  7.68it/s, loss=3.16, v_num=pqgq]
Validating:  70% 57/82 [00:07<00:02,  8.53it/s][A
Validating:  71% 58/82 [00:07<00:03,  7.82it/s][A
Validating:  72% 59/82 [00:07<00:02,  7.97it/s][A
Epoch 7:  76% 69/91 [00:08<00:02,  7.68it/s, loss=3.16, v_num=pqgq]
Validating:  73% 60/82 [00:08<00:02,  7.45it/s][A
Validating:  74% 61/82 [00:08<00:02,  7.74it/s][A
Validating:  76% 62/82 [00:08<00:02,  7.31it/s][A
Epoch 7:  79% 72/91 [00:09<00:02,  7.65it/s, loss=3.16, v_num=pqgq]
Validating:  77% 63/82 [00:08<00:02,  7.61it/s][A
Validating:  78% 64/82 [00:08<00:02,  7.80it/s][A
Validating:  79% 65/82 [00:08<00:02,  7.39it/s][A
Epoch 7:  82% 75/91 [00:09<00:02,  7.66it/s, loss=3.16, v_num=pqgq]
Validating:  82% 67/82 [00:08<00:01,  7.95it/s][A
Epoch 7:  86% 78/91 [00:10<00:01,  7.70it/s, loss=3.16, v_num=pqgq]
Validating:  84% 69/82 [00:09<00:01,  8.40it/s][A
Validating:  85% 70/82 [00:09<00:01,  8.24it/s][A
Epoch 7:  89% 81/91 [00:10<00:01,  7.74it/s, loss=3.16, v_num=pqgq]
Validating:  88% 72/82 [00:09<00:01,  8.56it/s][A
Validating:  89% 73/82 [00:09<00:01,  8.16it/s][A
Validating:  90% 74/82 [00:09<00:00,  8.03it/s][A
Epoch 7:  92% 84/91 [00:10<00:00,  7.73it/s, loss=3.16, v_num=pqgq]
Validating:  91% 75/82 [00:09<00:00,  7.89it/s][A
Validating:  94% 77/82 [00:10<00:00,  7.88it/s][A
Epoch 7:  96% 87/91 [00:11<00:00,  7.73it/s, loss=3.16, v_num=pqgq]
Validating:  95% 78/82 [00:10<00:00,  7.97it/s][A
Validating:  96% 79/82 [00:10<00:00,  8.03it/s][A
Validating:  98% 80/82 [00:10<00:00,  7.73it/s][A
Epoch 7:  99% 90/91 [00:11<00:00,  7.73it/s, loss=3.16, v_num=pqgq]
Validating:  99% 81/82 [00:10<00:00,  7.68it/s][A
Validating: 100% 82/82 [00:10<00:00,  8.04it/s][A[['Stanford University', 'Democratic Party', 'chief executive officer', 'Democratic Party', 'France 5'], ['', 'chief executive officer', 'S.L. Benfica', 'Yuriy Davydenko', 'France 5'], ['S.L. Benfica', 'France 5', '', 'Yuriy Krot', 'Valencia CF'], ['', 'Vice-President of Finland', 'Democratic Party', 'Vice-President of Hungary', 'Democratic Convergence of Catalonia'], ['Vice-President of the Philippines', 'Eurostar', 'chief executive officer', 'Birmingham City F.C.', 'Stanford University'], ['Dmitri Dmitrievich', 'France 5', 'United States Department of Justice', 'United States of America', 'Germany'], ['Toronto Raptors', 'Yuriy Krot', 'Leicester City F.C.', 'Democratic Party', 'France 5'], ['The New York Times', 'Stanford University', 'United States Department of Education', 'United States Department of Education', 'S.L. Lawrence'], ['United States Department of Education', 'Vice-President of the Philippines', '', 'Olympique Lyonnais', 'S.L. Rajapaksa'], ['Al Jazeera English', 'Zhejiang University', 'Birmingham City F.C.', 'Ukraine', 'Wells Fargo'], ['chief executive officer', 'Mauricio Macri', 'chief executive officer', 'Vice-President of Singapore', 'Vice-President of Norway'], ['Birmingham City F.C.', 'France 5', 'France 5', 'S.L. Benfica', 'Stanford University'], ['France 5', 'Democratic Party', 'Vicenza', 'S.L. Milan', 'Leicester City F.C.'], ['France 5', 'Pennsylvania State Government', 'Michael Gove', 'France 5', 'Yuriy Krot'], ['Democratic Party of Malaysia', 'Valencia CF', 'India Today', 'Netscape Communications Corporation', 'Cristiano Ronaldo'], ['chief executive officer', 'Vice-President of Poland', 'France 5', 'United States of America', 'Al Jazeera English'], ['Toronto Raptors', 'SK Rapid Wien', 'France 5', 'Democratic Union for a Popular Movement', 'Jeremy Corbyn'], ['chief executive officer', 'chief executive officer', '', 'Olympique Lyonnais', 'Silvio Berlusconi'], ['Democratic Party', 'Democratic Convergence of Catalonia', 'FIFA', 'Prime Minister of Turkey', 'Democratic Convergence of Catalonia'], ['Kansas City Chiefs', 'Democratic Party', 'France 5', 'United States of America', 'Toronto Raptors'], ['chief executive officer', 'Yongjiang University', 'Ferrovie dello Stato Italiane', 'Toronto Raptors', 'eljko eljko'], ['United States Department of Education', 'France 5', 'Cristiano Ronaldo', 'Vice-President of the European Commission', 'Vice-President of Turin'], ['Toronto Raptors', 'S.L. Benfica', 'The New York Times', 'United States Department of State', 'France 5'], ['United States of America', 'Birmingham City F.C.', 'Banco del Norte', '', 'S.L. Benfica'], ['Democratic Convergence of Catalonia', 'The Walt Disney Company', 'Democratic Convergence of Catalonia', 'Greece', 'France 5'], ['chief executive officer', 'Toronto Raptors', 'Nicolás Maduro', 'Democratic Party', 'S.L. Benfica'], ['Ofcom', 'chief executive officer', 'Leicester City F.C.', 'ONO', ''], ['United States of America', 'SourceForge', 'Vice-President of China', 'The Nature Conservancy', 'The Coca-Cola Company'], ['United States Department of Education', 'Cristian Dulca', 'France 5', '', 'Los Angeles Angels'], ['', 'S.L. Benfica', 'Toronto Raptors', 'Valencia CF', 'chief executive officer'], ['Birmingham City F.C.', 'France 5', 'United States Department of Education', 'chief executive officer', 'United States of America'], ["People's Party for Freedom and Democracy", '', 'Kevitsa', "People's Party for Freedom and Democracy", "People's Party for Freedom and Democracy"], ['Democratic Union of South Africa', 'Sweden Democrats', 'Birmingham City F.C.', 'Sven-Göran Eriksson', 'United States of America'], ['chief executive officer', 'Vice-President of the Philippines', '', 'Toronto Raptors', 'Mauricio Macri'], ['Olympique Lyonnais', '', '', 'Democratic Party', 'University of Ghana'], ['chief executive officer', '', 'Vice-President of the European Commission', 'Russia', ''], ['', 'Democratic Party of Korea', 'Democratic Union of Sri Lanka', 'Birmingham City F.C.', 'United States of America'], ['The National Portrait Gallery', "People's Party for Freedom and Democracy", 'England and Wales Cricket Board', 'Olympique Lyonnais', 'Kongregat'], ['Los Angeles Angels', 'Vice-President of the World', 'United States Department of Education', 'Kre', 'FIA Europe'], ['Vice-President of the Philippines', 'Democratic Convergence of Catalonia', 'Al Jazeera English', 'Vice-President of Serbia', 'chief executive officer'], ['United States Navy', 'United States Senate', 'Democratic Convergence of Romania', 'Democratic Union for a Popular Movement', ''], ['Toronto Raptors', 'France 5', "People's Party for Freedom and Democracy", 'Liaoning', 'Los Angeles Times'], ['Yuriy Zhukov', "People's Party for Freedom and Democracy", 'Birmingham City F.C.', 'S.L. Benfica', 'chief executive officer'], ['France 5', 'chief executive officer', 'Vice-President of the European Commission', 'Al Jazeera English', 'Democratic Party'], ['United States Department of Justice', 'France 5', 'Yuriy Yuriyev', "People's Party for Freedom and Democracy", 'Vice-President of the Navy'], ['Xi Jinping', 'Entercom', 'France 5', 'Toronto Raptors', 'United States of America'], ['France 5', 'Jr.', 'The People of Freedom', 'The New York Times', 'Vice-Chancellor of Germany'], ['University of Tokyo', 'Democratic Party', 'Vice-President of the European Commission', 'France 5', "People's Party for Freedom and Democracy"], ['University of Lagos', 'Democratic Party', 'witochr', 'chief executive officer', 'Toronto Raptors'], ['Vice-President of the Philippines', 'ONO', 'Birmingham City F.C.', 'chief executive officer', 'Vice-President of the Philippines'], ['Toronto Raptors', 'S.L. Benfica', 'France 5', 'Vice-President of the Philippines', 'Vice-President of Finland'], ['Democratic Party', 'Leicester City F.C.', 'Los Angeles Angels', 'Vice-President of the European Commission', 'Vice-President of the Philippines'], ['Vice-President of the Philippines', 'Toronto Raptors', 'Democratic Union of Lithuania', 'Toronto Raptors', 'United States of America'], ['chief executive officer', 'United States Information Agency', 'S.L. Benfica', 'Democratic Party', 'United States Department of Education'], ['Bergen Commuter Rail', 'United India Party', 'Romanian Football Federation', '', 'chief executive officer'], ['chief executive officer', 'United States Information Agency', 'Honduran', 'Russia Today', 'United States Department of Education'], ['', 'Democratic Party', 'France 5', 'Nicolás Almagro', 'United Arab Emirates'], ['Toronto Raptors', "People's Party for Freedom and Democracy", 'Democratic Convergence of Catalonia', 'Birmingham City F.C.', 'Stanford University'], ['chief executive officer', 'Valencia CF', 'Democratic Party', 'chief executive officer', 'Union for a Popular Movement'], ['Democratic Convergence of Catalonia', 'chief executive officer', 'United States Department of Education', 'S.L. Benfica', 'Vice-President of Pakistan'], ['Democratic Party', 'Ukraine', 'chief executive officer', 'United Malays National Organisation', 'Vicenza'], ['Democratic Convergence of Catalonia', 'S.L. Benfica', 'University of the South', 'Democratic Convergence of Catalonia', 'Yuriy Krot'], ['Cristian Dulca', 'Democratic Party', 'France 5', 'Toronto Raptors', 'Al Jazeera English'], ['Russia Today', 'Toronto Raptors', 'Yves Saint Laurent', 'S.L. Benfica', 'Stanford University'], ['Syed Ali Shah', 'United States Department of Education', 'Hickory Newspapers', "People's Party for Freedom and Democracy", 'The New York Times'], ['Stanford University', 'Toronto Raptors', 'Democratic Party', 'Christian XIII', "Sean O'Connor"], ['Democratic Convergence of Catalonia', 'University of Havana', 'Wheaton Corporation', 'France 5', 'Vice-President of Milan'], ['Valencia CF', 'Toronto Raptors', 'chief executive officer', 'The Federal Building Commission', 'chief executive officer'], ['ONO', 'France 5', 'France 5', 'lvaro Uribe', 'University of Tehran'], ['Benfica', '', 'Germany', 'Emmanuel Macron', "People's Party for Freedom and Democracy"], ['ONO', 'chief executive officer', 'Stanford University', 'Boxer TV', 'Charlotte Hornets'], ['Valencia CF', 'S.L. Sabah', 'S.L. Benfica', 'Silvio Berlusconi', 'Michael C. Smith'], ["People's Party for Freedom and Democracy", 'United States Department of Education', 'Teachta Dála', 'France 5', 'United States of America'], ['S.L. Benfica', 'Toronto Raptors', 'Michael Mann', "People's Party for Freedom and Democracy", ''], ['Vice-President of India', 'Wolverhampton Wanderers', 'Stanford University', 'Vice-President of the World', 'United States Department of Education'], ['Valencia CF', 'Wales Democrat', 'Toronto Raptors', 'Toronto Raptors', ''], ['The People of Freedom', 'United States Department of Education', 'Silvio Berlusconi', "People's Party for Freedom and Democracy", 'Democratic Party'], ['Vicenza', 'S.L. Benfica', 'France 5', 'Vicenza', 'Valencia CF'], ['Stanford University', 'United States of America', '', 'Vice-President of Norway', 'S.L. Benfica'], ['chief executive officer', 'Vice-President of Norway', 'chief executive officer', "People's Party for Freedom and Democracy", ''], ['S.L. Sagar', 'United States Naval Academy', 'PEN International', 'S.L. Benfica', 'Vice-President of the European Commission'], ['Omar al-Bashir', 'Democratic Party', 'The New York Times', 'of New Zealand', 'Vicenza']]
Epoch 7: 100% 91/91 [00:11<00:00,  7.62it/s, loss=3.16, v_num=pqgq]
                                               [A
Epoch 7: 100% 91/91 [00:12<00:00,  7.33it/s, loss=3.16, v_num=pqgq]
wandb: Waiting for W&B process to finish... (success).
wandb: - 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: \ 0.001 MB of 0.001 MB uploaded (0.000 MB deduped)
wandb: | 0.001 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: / 0.001 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: - 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: \ 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: | 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: / 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: - 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: \ 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: | 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb: / 0.009 MB of 0.009 MB uploaded (0.000 MB deduped)
wandb:                                                                                
wandb: Synced T5_small_templama(2010)_lr.001_baseline: https://wandb.ai/tjung2/continual_learning_3/runs/2urqpqgq
wandb: Synced 6 W&B file(s), 0 media file(s), 0 artifact file(s) and 0 other file(s)
wandb: Find logs at: ./wandb/run-20220811_032007-2urqpqgq/logs
