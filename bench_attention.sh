#!/bin/bash

source ~/.bashrc
conda init
conda activate llmperf

start=2000
end=32000
factor=2

while [ $start -le $end ]
do
    echo "Running benchmark with mean-input-tokens = $start"

    python token_benchmark_ray.py --model Qwen/Qwen2.5-7B-Instruct \
    --mean-input-tokens $start \
    --stddev-input-tokens 10 \
    --mean-output-tokens 1 \
    --stddev-output-tokens 0 \
    --max-num-completed-requests 2 \
    --timeout 600 \
    --num-concurrent-requests 1 \
    --results-dir "result_outputs" \
    --llm-api openai \
    --additional-sampling-params '{}'

    start=$((start * factor))
done
