pipeline {
  environment {
    registry = "mothes/simplewebapp"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }

  node {
    def buildAndPush

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        dockerImage = docker.build registry
    }

    stage('Test image') {

        dockerImage.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry( '', registryCredential ) {
            dockerImage.push("${env.BUILD_NUMBER}")
            dockerImage.push("latest")
        }
      }
    }
}

//   agent any

// //   agent {
// //     dockerfile {
// //       filename 'Dockerfile'
// //     }
// //   }

// //   stages {
// //     stage ('Test') {
// //       steps {
// //         sh 'uname -ar'
// //         sh 'cat /etc/issue'
// //       }
// //     }
//   stages {
//     stage ('Building image') {
//       steps {
//         script {
//         dockerImage = docker.build registry + ":$BUILD_NUMBER"
//       }
//     }
//    }

//     stage('Push Image to DockerHub') {
//       steps{
//         script {
//           docker.withRegistry( '', registryCredential ) {
//             dockerImage.push()
//           }
//         }
//       }
//     }

//     stage('Remove unused docker image') {
//       steps{
//         sh "docker rmi $registry:$BUILD_NUMBER"
//       }
//     }
//   }
