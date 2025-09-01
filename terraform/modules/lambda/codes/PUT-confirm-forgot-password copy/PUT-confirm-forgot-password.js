const {
  CognitoIdentityProviderClient,
  ConfirmForgotPasswordCommand,
} = require("@aws-sdk/client-cognito-identity-provider");

const CLIENT_ID = process.env.CLIENT_ID;
const client = new CognitoIdentityProviderClient();

exports.lambda_handler = async (event) => {
  try {
    let body = event.body;
    if (typeof body === "string") body = JSON.parse(body);

    const { email, confirmation_code, new_password } = body;

    if (!email || !confirmation_code || !new_password) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: "Email, confirmation_code, and new_password are required" }),
      };
    }

    const input = {
      ClientId: CLIENT_ID,
      Username: email,
      ConfirmationCode: confirmation_code,
      Password: new_password,
    };

    const command = new ConfirmForgotPasswordCommand(input);
    await client.send(command);

    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Password has been reset successfully!" }),
    };
  } catch (error) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: error.message }),
    };
  }
};