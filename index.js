function parseBody(event) {
  return JSON.parse(
    event.isBase64Encoded
      ? atob(event.body)
      : event.body
  );
}

module.exports.handler = async (event, context) => {
  const method = event.requestContext.http.method;
  const body = parseBody(event);
  console.log(method, body);
  return "Hello world!\n"
}
