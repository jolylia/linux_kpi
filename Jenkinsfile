pipipeline {
    agent any

    environment {
        APP_NAME = 'my_go_app'
        DOCKER_IMAGE_NAME = 'my-go-app-image'
    }

    stages {
        stage('Clone Repository') {
            steps {
                // Крок клонування репозиторію
                checkout scm
            }
        }

        stage('Compile') {
            agent {
                // Використання Docker образу з підтримкою Go версії 1.21.3
                docker {
                    image 'golang:1.21.3'
                    reuseNode true
                }
            }
            steps {
                // Компіляція проекту на мові Go
                sh "CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -ldflags '-w -s -extldflags \"-static\"' -o ${APP_NAME} ."
            }
        }

        stage('Unit Testing') {
            agent {
                // Використання Docker образу з підтримкою Go версії 1.21.3
                docker {
                    image 'golang:1.21.3'
                    reuseNode true
                }
            }
            steps {
                // Виконання юніт-тестів
                sh "go test"
            }
        }

        stage('Archive Artifact and Build Docker Image') {
            parallel {
                stage('Archive Artifact') {
                    steps {
                        // Створення TAR-архіву артефакту
                        sh "tar -czvf ${APP_NAME}-${BUILD_NUMBER}.tar.gz ${APP_NAME}"
                    }
                }

                stage('Build Docker Image') {
                    steps {
                        // Створення Docker образу
                        sh "docker build --build-arg APP_NAME=${APP_NAME} -t ${DOCKER_IMAGE_NAME}:${BUILD_NUMBER} ."
                    }
                }
            }
        }
    }

    post {
        success {
            // Архівація успішна, артефакт готовий для використання та збереження
            archiveArtifacts artifacts: "${APP_NAME}-${BUILD_NUMBER}.tar.gz"
        }
        always {
            // Завершення пайплайну, можна додати додаткові кроки (наприклад, розгортання) за потребою
            echo 'Pipeline finished'
        }
    }
}
