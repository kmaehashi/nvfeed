#!/bin/bash -uex

rm -rf _generate
cp -a _skeleton _generate

python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for Ubuntu 24.04 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/' \
    --file-suffix '.deb' \
    --output '_generate/cuda-ubuntu2404-x86_64.atom'
python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for RHEL 10 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/rhel10/x86_64/' \
    --file-suffix '.rpm' \
    --output '_generate/cuda-rhel10-x86_64.atom'
