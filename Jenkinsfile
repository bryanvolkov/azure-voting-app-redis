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
                powershell(script: """
                # start app line miss!
                ./scripts/test_container.ps1
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
                powershell(script: """
                    pytest ./tests/test/sample.py
                """)
            }
        }

        stage('Stop test app') {
            steps {
                powershell(script: """
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
