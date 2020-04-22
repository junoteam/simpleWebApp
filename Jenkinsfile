pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
  }
  stages {
    stage('Test') {
      steps {
        sh 'uname -ar'
        sh 'cat /etc/issue'
      }
    }
  }
  node {
    checkout scm
    def customImage = docker.build("mothes/simplewebapp:${env.BUILD_ID}")
  }
}