pipeline {
    agent any

    environment {
        REPO_URL = 'https://github.com/gsmsk/hello-java-maven.git'
        BRANCH = 'master'  // or 'main', depending on your default branch
        APP_NAME = 'java-app'
        DOCKER_PORT = '8080'
        HOST_PORT = '8080'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    echo "Cloning repository..."
                    git branch: "${BRANCH}", url: "${REPO_URL}"
                }
            }
        }
        stage('Build with Maven') {
            steps {
                script {
                    echo "Building with Maven..."
                    sh 'mvn clean install'
                }
            }
        }
        stage('Dockerize') {
            steps {
                script {
                    echo "Building Docker image..."
                    sh 'docker build -t ${APP_NAME} .'
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                    echo "Running Docker container..."
                    sh 'docker run -d -p ${HOST_PORT}:${DOCKER_PORT} --name ${APP_NAME}-container ${APP_NAME}'
                }
            }
        }
        stage('Expose Application') {
            steps {
                echo "The application is running at http://localhost:${HOST_PORT}"
            }
        }
    }

    post {
        always {
            echo "Cleaning up..."
            sh 'docker stop ${APP_NAME}-container || true'
            sh 'docker rm ${APP_NAME}-container || true'
            sh 'docker rmi ${APP_NAME} || true'
        }
    }
}

