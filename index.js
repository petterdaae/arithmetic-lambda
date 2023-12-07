function parseBody(event) {
  return JSON.parse(
    event.isBase64Encoded
      ? atob(event.body)
      : event.body
  );
}

function clientError(message) {
  return {
    statusCode: 400,
    body: {
      message
    }
  }
}

module.exports.handler = async (event, context) => {
  const body = parseBody(event);

  const operation = body.operation;
  const left = body.left;
  const right = body.right;

  let result = null;

  switch (operation) {
    case "ADD":
      result = left + right
      break

    case "SUBTRACT":
      result = left - right
      break

    case "MULTIPLY":
      result = left * right
      break

    case "DIVIDE":
      result = left / right
      break

    default:
      return clientError("Invalid operation")
  }

  return {
    request: { operation, left, right },
    result
  }
}
