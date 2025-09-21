const {
  CognitoIdentityProviderClient,
  ConfirmSignUpCommand,
} = require("@aws-sdk/client-cognito-identity-provider");

const CLIENT_ID = process.env.CLIENT_ID;

console.log("CLIENT_ID from environment variable:", CLIENT_ID); 

const client = new CognitoIdentityProviderClient();

exports.lambda_handler = async (event) => {
  try {
    let body = event.body;
    if (typeof body === "string") {
      body = JSON.parse(body);
    }

    const { email, confirmation_code } = body;

    if (!email || !confirmation_code) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: "Email and confirmation_code are required" }),
      };
    }

    const input = {
      ClientId: CLIENT_ID,
      Username: email,
      ConfirmationCode: confirmation_code,
    };

    const command = new ConfirmSignUpCommand(input);
    const response = await client.send(command);

    return {
      statusCode: 200,
      body: {
        message: "User confirmed successfully!",
        data: response,
      },
    };
  } catch (error) {
    console.error(error.message);
    return {
      statusCode: 400,
      body: {
        error: error.message || "Confirmation failed",
      },
    };
  }
};
