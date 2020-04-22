pipeline {
  
  stages {
    stage('Building Docker Image') {
      agent {
      dockerfile {
      filename 'Dockerfile'
        }
      }
      steps {
        sh 'uname -ar'
        sh 'cat /etc/issue'
      }
    }
  }
}