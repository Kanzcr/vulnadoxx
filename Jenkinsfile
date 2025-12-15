pipeline {
    agent any

    tools {
        maven 'Maven_3'
    }

    environment {
        GIT_REPO = 'https://github.com/Kanzcr/vulnadoxx.git'
        GIT_CREDENTIALS = 'github-token-kanz'
        SONAR_PROJECT_KEY = 'vulnadoxx'
        SONAR_PROJECT_NAME = 'vulnadoxx'
    }

    stages {

        stage('Checkout') {
            steps {
                git url: "${GIT_REPO}", credentialsId: "${GIT_CREDENTIALS}", branch: 'master'
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Docker Build & Push') {
            steps {
                script {
                    def imageName = "kanzcr/vulnadoxx:latest"
                    bat "docker build -t ${imageName} ."

                    withCredentials([usernamePassword(
                        credentialsId: 'dockerhub-pass', // ID credential di Jenkins
                        usernameVariable: 'DOCKER_USER',
                        passwordVariable: 'DOCKER_PASS'
                    )]) {
                        bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"
                        bat "docker push ${imageName}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo 'Backend pipeline berhasil!'
        }
        failure {
            echo 'Backend pipeline gagal.'
        }
    }
}