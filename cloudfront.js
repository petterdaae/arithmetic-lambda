function clientError(message) {
  return {
    statusCode: 400,
    body: message
  }
}

function handler(event) {
  try {
    var operation = event.request.querystring.operation.value;
    var left = parseFloat(event.request.querystring.left.value);
    var right = parseFloat(event.request.querystring.right.value);

    var result;
    switch (operation) {
      case "ADD":
        result = left + right;
        break;

      case "SUBTRACT":
        result = left - right;
        break;

      case "MULTIPLY":
        result = left * right;
        break;

      case "DIVIDE":
        result = left / right;
        break;

      default:
        return clientError("Invalid operation")
    }

  } catch (e) {
    return clientError("Invalid request")
  }

  return {
    statusCode: 200,
    headers: {
      "content-type": {
        "value": "application/json"
      }
    },
    body: {
      encoding: "text",
      data: JSON.stringify({
        result
      })
    },
  }
}
