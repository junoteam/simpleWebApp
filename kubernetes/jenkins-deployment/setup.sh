#!/bin/bash 
# GKE only setup

echo "Creating attachable volume in Google cloud"
gcloud compute disks create --size 20GB kubernetes-jenkins

echo "Generating private key and cert"
ssh-keygen -t rsa -b 4096 -C "jenkins" -f jenkins-ssh -q -N ""

echo "Setup of known-hosts file"
GITHUB_IP=$(host github.com | awk '{ print $4 ; exit 1}')
ssh-keyscan -t rsa -T 10 github.com >> known-hosts
ssh-keyscan -t rsa -T 10 $GITHUB_IP >> known-hosts

echo "Creating Kube secret"
kubectl create secret generic jenkins-ssh --from-file=jenkins-ssh --from-file=jenkins-ssh.pub --from-file=known-hosts --from-file="config=ssh_config"

echo "Cleaning out"
rm -v jenkins-ssh*
rm -v known-hosts

echo "Creating Jenkins deployment in Kube"
kubectl create -f jenkins-deployment.yml