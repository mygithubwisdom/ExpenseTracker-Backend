const {
	CognitoIdentityProviderClient,
	InitiateAuthCommand,
  } = require("@aws-sdk/client-cognito-identity-provider");
  
  const CLIENT_ID = process.env.CLIENT_ID;
  
  const client = new CognitoIdentityProviderClient();
  
  exports.lambda_handler = async (event) => {
	try {
	  let body = event.body;
	  if (typeof body === "string") {
		body = JSON.parse(body);
	  }
  
	  const { email, password } = body;
  
	  if (!email || !password) {
		return {
		  statusCode: 400,
		  body: JSON.stringify({ error: "Email and password are required" }),
		};
	  }
  
	  // Call Cognito for authentication
	  const input = {
		AuthFlow: "USER_PASSWORD_AUTH",
		ClientId: CLIENT_ID,
		AuthParameters: {
		  USERNAME: email,
		  PASSWORD: password,
		},
	  };
  
	  const command = new InitiateAuthCommand(input);
	  const response = await client.send(command);
  
	  return {
		statusCode: 200,
		body: {
		  message: "Sign in successful!",
		  tokens: response.AuthenticationResult, // contains AccessToken, IdToken, RefreshToken
		},
	  };
	} catch (error) {
	  console.error(error.message);
	  return {
		statusCode: 400,
		body: {
		  error: error.message || "Signin failed",
		},
	  };
	}
  };