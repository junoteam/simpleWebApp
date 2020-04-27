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
        dockerImage = docker.build registry + ":$BRANCH_NAME" + "-$BUILD_ID"
        }
      }
    }

    stage ('Test application') {
      steps {
        script { 
            dockerImage.inside {
            sh 'uname -ar'
            sh 'cat /etc/issue'
          }
        }
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

    stage('Deploy to Kubernetes') {
       steps {
        script { 
            dockerImage.inside {
            sh 'uname -ar'
            sh 'cat /etc/issue'
          }
        }
      }
    }

    stage('Remove unused docker image') {
      steps{
        sh "docker rmi $dockerImage"
        //sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $dockerImage:latest"
      }
    }
  }
}

