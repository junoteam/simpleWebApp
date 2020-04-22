pipeline {
  environment {
    registry = "mothes/simplewebapp"
    registryCredential = 'dockerhub'
  }

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

    stage ('Building image') {
      steps {
       script {
       docker.build registry + ":$BUILD_NUMBER"
      }
    }
   }
  }
}