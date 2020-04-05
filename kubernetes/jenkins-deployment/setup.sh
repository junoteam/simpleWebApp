gcloud compute disks create --size 20GB kubernetes-jenkins

ssh-keygen -t rsa -b 4096 -C "jenkins" -f jenkins-ssh -q -N ""
GITHUB_IP=$(getent hosts github.com | awk '{ print $1 }')
ssh-keyscan -t rsa -T 10 github.com >> known-hosts
ssh-keyscan -t rsa -T 10 $GITHUB_IP >> known-hosts
getent hosts github.com | awk '{ print $1 }'
kubectl create secret generic jenkins-ssh --from-file=jenkins-ssh --from-file=jenkins-ssh.pub --from-file=known-hosts --from-file="config=ssh_config"
rm jenkins-ssh*
rm known-hosts

kubectl create -f jenkins-deployment.yaml
kubectl create -f jenkins-service.yaml
