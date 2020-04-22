pipeline {
  environment {
    registry = "mothes/simplewebapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }

  agent any

  stages {
    stage ('Building image') {
      steps {
        script {
        dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }

    stage ('Test') {
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

    stage('Push Image to DockerHub') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
            dockerImage.push("latest")
          }
        }
      }
    }

    stage('Remove unused docker image') {
      steps{
        sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
      }
    }
  }
}

