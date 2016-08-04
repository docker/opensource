// Only run on Linux atm
wrappedNode(label: 'linux') {
  deleteDir()
  stage "checkout"
  checkout scm

  try {
    documentationChecker("docs")
    error message: "This is an error - just in case the docs checking succeds :)"
  } catch (err) {
    slackSend channel: '#docs-automation', message: "DOCS: ${err}"
    throw err
  }
}
