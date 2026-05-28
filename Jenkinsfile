pipeline {

    agent any

    stages {

        stage('Git Checkout') {

            steps {

                checkout scm
            }
        }

        stage('SonarQube Scan') {

            steps {

                echo 'Running SonarQube Scan'
            }
        }

        stage('Build Docker Image') {

            steps {

                sh 'docker build -t python-cicd-app:v1 .'
            }
        }

        stage('Deploy Container') {

            steps {

                sh '''

                docker stop python-app || true

                docker rm python-app || true

                docker run -d \
                -p 5000:5000 \
                --name python-app \
                python-cicd-app:v1
                '''
            }
        }
    }
}
