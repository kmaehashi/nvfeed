#!/bin/bash -uex

rm -rf _generate
cp -a _skeleton _generate

python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for Ubuntu 20.04 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/' \
    --file-suffix '.deb' \
    --output '_generate/cuda-ubuntu2004-x86_64.atom'
python3 nvfeed.py \
    --name 'NVIDIA CUDA Packages for RHEL 8 (x86_64)' \
    --url 'https://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/' \
    --file-suffix '.rpm' \
    --output '_generate/cuda-rhel8-x86_64.atom'
