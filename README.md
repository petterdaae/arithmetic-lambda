# arithmetic-lambda

- `/terraform` contains the necessary infrastructure. It is also used to deploy new versions of the lambda.
- `lambda.js` contains the lambda code.
- `cloudfront.js` contains the CloudFront function code.

## Examples

The lambda function reads three parameters from the request body, `operation`, `left` and `right`:
```
curl https://e4mewkyvkkby4klt5w6ffhorpq0lcasn.lambda-url.eu-north-1.on.aws \
  -d '{"operation": "ADD", "left": 1, "right": 2}'
```

The CloudFront function reads three query parameters, `operation`, `left` and `right`:
```
curl 'https://dmfsnsw659qrm.cloudfront.net?operation=ADD&left=1&right=2'
```
