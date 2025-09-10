// Import necessary modules
const {
  CognitoIdentityProviderClient,
  SignUpCommand,
} = require("@aws-sdk/client-cognito-identity-provider");
const mongoose = require("mongoose");
const crypto = require("crypto");

// Access environment variables
const CLIENT_ID = process.env.CLIENT_ID;
const CLIENT_SECRET = process.env.CLIENT_SECRET;
const USER_POOL_ID = process.env.USER_POOL_ID;
const MONGO_URI = process.env.MONGODB_URI;

// Logic to connect to DB
let isConnected = false;
let connectionPromise = null;

const connectToDB = async () => {
  if (isConnected) return;
  
  if (!connectionPromise) {
    connectionPromise = mongoose.connect(MONGO_URI)
      .then(() => {
        isConnected = true;
        console.log("MongoDB connected successfully");
      })
      .catch((error) => {
        console.log("Failed to connect to DB");
        connectionPromise = null;
        throw error;
      });
  }
  
  return connectionPromise;
};

// Define User Schema
const UserSchema = new mongoose.Schema({
  first_name: String,
  last_name: String,
  email: String,
  phone_number: String,
  role: String,
  user_sub: String,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now },
});

// Prevent model overwrite in Lambda warm starts
const User = mongoose.models.User || mongoose.model("User", UserSchema);

// Instantiate Cognito client
const client = new CognitoIdentityProviderClient();

// Generate SecretHash (if needed)
const generateSecretHash = (username, clientId, clientSecret) => {
  return crypto
    .createHmac("SHA256", clientSecret)
    .update(username + clientId)
    .digest("base64");
};

// Lambda handler
exports.lambda_handler = async (event) => {
  try {
    await connectToDB();

    // Safe body parsing
    let body = event.body;
    if (typeof body === "string") {
      body = JSON.parse(body);
    }

    const { first_name, last_name, email, phone_number, role, password } = body;

    const input = {
      ClientId: CLIENT_ID,
      Username: email,
      Password: password,
      UserAttributes: [
        { Name: "family_name", Value: last_name },
        { Name: "given_name", Value: first_name },
        { Name: "email", Value: email },
        { Name: "phone_number", Value: phone_number },
        { Name: "custom:role", Value: role },
      ],
    };

    const command = new SignUpCommand(input);
    const response = await client.send(command);

    const user_sub = response.UserSub; 
    const user = new User({
      first_name,
      last_name,
      email,
      phone_number,
      role,
      user_sub,
    });

    await user.save();

    return {
      statusCode: 201,
      body: {
        message:
          "Sign up successful. Please check your email for verification code.",
        data: response,
      },
    };
  } catch (error) {
    console.error(error.message);
    return {
      statusCode: 400,
      body: {
        error: error.message || "Sign-up not successful",
      },
    };
  }
};
 