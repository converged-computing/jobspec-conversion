#!/bin/bash
python process-jobspecs.py --model mistralai/Codestral-22B-v0.1 --batch-size 4 --output-file /tmp/output.csv --oneshot --min-ccn 1.0 --max-ccn 2.0 --max-chars 16000 --max-files 100 --prompt-per-rm

