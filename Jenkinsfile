pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "merlinpratheesh/kubernetTestApp:latest"
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/merlinprathee/kubernetTestApp.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Build Angular') {
            steps {
                bat 'npx ng build --prod'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_IMAGE% ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat 'echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin'
                    bat "docker push %DOCKER_IMAGE%"
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat 'kubectl apply -f k8s-deployment.yaml'
            }
        }
    }
}
