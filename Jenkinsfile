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
}