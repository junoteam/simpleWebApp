pipeline {
  agent {
    dockerfile {
      filename 'pipline'
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