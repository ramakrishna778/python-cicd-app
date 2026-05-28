pipeline {

    agent any

    environment {

        SCANNER_HOME = tool 'sonar-scanner'
    }

    stages {

        stage('Git Checkout') {

            steps {

                checkout scm
            }
        }

        stage('SonarQube Analysis') {

            steps {

                withSonarQubeEnv('sonarqube') {

                    sh '''
                    $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectKey=python-cicd-app \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://sonarqube:9000
                    '''
                }
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
