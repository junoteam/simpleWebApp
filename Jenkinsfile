pipeline {
    agent { dockerfile true }
    stages {
        stage('Test') {
            steps {
                sh 'uname -ar'
                sh 'cat /etc/issue'
            }
        }
    }
}
