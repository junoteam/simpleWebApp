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
    stage ('Test') {
      steps {
        sh 'uname -ar'
        sh 'cat /etc/issue'
      }
    }

    agent docker stage ('Building image') {
      steps {
       script {
       docker.build registry + ":$BUILD_NUMBER"
      }
    }
   }

    agent docker stage('Push Image to DockerHub') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }

    agent docker stage('Remove unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
      }
    }
  }
}