pipeline {
  environment {
    registry = "mothes/simplewebapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
    // kube_deployment = 'deployment/simple-web-app'
  }

  agent any

  stages {
    stage ('Building image') {
      steps {
        script {
        dockerImage = docker.build registry + ":$BRANCH_NAME"
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

    // stage('Deploy to Kubernetes') {
    //    steps {
    //     script { 
    //       sh "kubectl set image $kube_deployment simple-web-app=$dockerImage"
    //       sh "kubectl rollout status $kube_deployment"
    //       sh "kubectl rollout history $kube_deployment"
    //     }
    //   }
    // }

    stage('Remove unused docker image') {
      steps{
        sh "docker rmi $registry:$BRANCH_NAME"
        //sh "docker rmi $registry:$BUILD_NUMBER"
        sh "docker rmi $registry:latest"
      }
    }
  }
}

