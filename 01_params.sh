#!/bin/bash
# Change CRLF to LF if on Windows

# TODO: Set your dockerhub user
user="readydocker1"

# --- STAGE 1 (Java Base) ---
file1="Dockerfile1"
container1="jenkins_v1"
image1="$user/jenkins_dind:v1"

# --- STAGE 2 (Jenkins Controller) ---
file2="Dockerfile2"
container2="jenkins_v2"
image2="$user/jenkins_dind:v2"

# --- STAGE 3 (Final DinD Image) ---
file3="Dockerfile3"
container3="jenkins_dind"
image3="$user/jenkins_dind:latest"