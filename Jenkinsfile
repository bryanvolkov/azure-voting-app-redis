pipeline {
    agent any

    stages {
        stage('Verify Branch') {
            steps {
                // echo "$GIT_BRANCH"
                sh(script: 'echo "Hello World"')
            }
        }

        stage('Docker Build'){
            steps{
                // sh(script: 'sudo su')
                sh(script: 'docker images -a')
                sh(script: """
                    cd azure-vote/
                    docker images -a
                    docker build -t jenkins-pipeline .
                    docker images -a
                    cd ..
                """)
            }
        }

        stage('Start test app') {
            steps{
                sh(script: """
                # start app line miss!
                docker-compose up -d ./scripts/test_container.sh
                """)
            }
            post {
                success{
                    echo "App started successfully :)"
                }
                failure {
                    echo "app failed to start :("
                }
            }
        }

        stage('Run Tests') {
            steps {
                sh(script: """
                    pytest ./tests/test/sample.py
                """)
            }
        }

        stage('Stop test app') {
            steps {
                sh(script: """
                    docker-compose down
                """)
            }
        }

        // stage('Push Container') {
        //     steps {
        //         echo "Workspace is $WORKSPACE"
        //         dir("$WORKSPACE/azure-vote") {
        //             docker.withRegistry('https://index.docker.io/v1/', 'DockerHub')  {
        //                 def image = docker.build('blackdentech/jenkins-course:latest')
        //                 image.push()
        //             }
        //         }
        //     }
        // }
    }
    
}
