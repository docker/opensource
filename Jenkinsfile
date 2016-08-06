wrappedNode(label: 'docker') {
  deleteDir()
  stage "checkout"
  checkout scm

  tokens = "${env.JOB_NAME}".tokenize('/')
  pr = "${CHANGE_URL}"
  echo "running ${pr}, job ${env.BUILD_ID}"
  sh "env"

  try {
    documentationChecker("docs")
  } catch (err) {
    slackSend channel: '#docs-automation', message: "ERROR: <a href='${env.CHANGE_URL}'>PR#${pr}</a> - see [jenkins job console](${BUILD_URL}/console)]"
    throw err
  }
}
