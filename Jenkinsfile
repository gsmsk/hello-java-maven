pipeline {
    agent any

    environment {
        // Define environment variables
        REPO_URL = 'https://github.com/gsmsk/hello-java-maven.git'  // Git repository URL
        BRANCH = 'main'  // Git branch to use
        APP_NAME = 'your-java-app'  // Docker image name
        DOCKER_PORT = '8080'  // Port exposed by Docker container
        HOST_PORT = '8080'  // Port on the host system to map
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Pull the source code from Git
                    echo "Cloning repository from Git..."
                    git branch: "${BRANCH}", url: "${REPO_URL}"
                }
            }
        }

        stage('Build with Maven') {
            steps {
                script {
                    // Build the Java project using Maven
                    echo "Building the application with Maven..."
                    sh 'mvn clean install'
                }
            }
        }

        stage('Dockerize Application') {
            steps {
                script {
                    // Build the Docker image for the Java application
                    echo "Building the Docker image..."
                    sh 'docker build -t ${APP_NAME} .'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container and expose the application
                    echo "Running the application in a Docker container..."
                    sh 'docker run -d -p ${HOST_PORT}:${DOCKER_PORT} --name ${APP_NAME}-container ${APP_NAME}'
                }
            }
        }

        stage('Expose Application') {
            steps {
                script {
                    // Inform the user that the application is running and exposed
                    echo "The application is running and exposed on port ${HOST_PORT}."
                    echo "Access the application at http://localhost:${HOST_PORT}"
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker container and image after the build
            echo "Cleaning up..."
            sh 'docker stop ${APP_NAME}-container || true'
            sh 'docker rm ${APP_NAME}-container || true'
            sh 'docker rmi ${APP_NAME} || true'
        }
    }
}
