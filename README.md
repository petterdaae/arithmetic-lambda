# arithmetic-lambda

- `/terraform` contains the necessary infrastructure. It is also used to deploy new versions of the lambda.
- `index.js` contains the actual lambda code.

## `curl` examples

`curl https://e4mewkyvkkby4klt5w6ffhorpq0lcasn.lambda-url.eu-north-1.on.aws -d '{"operation": "ADD", "left": 1, "right": 2}'`

`curl 'https://dmfsnsw659qrm.cloudfront.net?operation=ADD&left=1&right=2'`
