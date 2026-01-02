pipeline {
    agent any

    environment {
        AWS_CREDENTIALS = credentials('aws_creds')
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_creds')
        IMAGE_NAME = 'mohdayazz/apachewebsite:latest'
    }

    stages {

        stage('Clone GitHub') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/mohdayaz06/apachewebsite'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${IMAGE_NAME} .'
            }
        }

        stage('Login to DockerHub & Push Image') {
            steps {
                withDockerRegistry(
                    credentialsId: 'dockerhub_creds',
                    url: 'https://index.docker.io/v1/'
                ) {
                    sh 'docker push ${IMAGE_NAME}'
                }
            }
        }

        stage('Configure AWS EKS') {
            steps {
                withCredentials([
                    [
                        $class: 'AmazonWebServicesCredentialsBinding',
                        credentialsId: 'aws_creds'
                    ]
                ]) {
                    sh 'aws eks update-kubeconfig --region ap-south-1 --name ayazz-cluster'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yml'
                sh 'kubectl apply -f service.yml'
            }
        }
    }

    post {
        success {
            echo 'Pipeline executed successfully! Application deployed.'
        }
        failure {
            echo 'Pipeline failed. Check the logs.'
        }
    }
}
