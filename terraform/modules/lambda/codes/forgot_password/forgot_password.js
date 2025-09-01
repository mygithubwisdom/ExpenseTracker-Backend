const {
  CognitoIdentityProviderClient,
  ForgotPasswordCommand,
} = require("@aws-sdk/client-cognito-identity-provider");

const CLIENT_ID = process.env.CLIENT_ID;
const client = new CognitoIdentityProviderClient();

exports.lambda_handler  = async (event) => {
  try {
    let body = event.body;
    if (typeof body === "string") body = JSON.parse(body);

    const { email } = body;

    if (!email) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: "Email is required" }),
      };
    }

    const input = { ClientId: CLIENT_ID, Username: email };
    const command = new ForgotPasswordCommand(input);
    await client.send(command);

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Password reset code sent to your email." }),
    };
  } catch (error) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: error.message }),
    };
  }
};