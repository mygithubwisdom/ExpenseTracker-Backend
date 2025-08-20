// Import necessary modules
import {
  CognitoIdentityProviderClient,
  ForgotPasswordCommand
} from "@aws-sdk/client-cognito-identity-provider";
import mongoose from "mongoose";
import crypto from "crypto";

// Access environment variables
const CLIENT_ID = process.env.CLIENT_ID;
const CLIENT_SECRET = process.env.CLIENT_SECRET;
const USER_POOL_ID = process.env.USER_POOL_ID;
const MONGO_URI = process.env.MONGO_URI;

// Logic to connect to DB
let isConnected = false;
const connectToDB = async () => {
  if (isConnected) {
    return;
  }
  try {
    await mongoose.connect(MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    isConnected = true;
    console.log("MongoDB connected successfully");
  } catch (error) {
    console.log("Failed to connect to DB");
    throw error;
  }
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
  updated_at: { type: Date, default: Date.now }
});

// Create user model and prevent model from overwriting with every new deploy
const User = mongoose.models.User || mongoose.model('User', UserSchema);

// Instantiate a new client class
const client = new CognitoIdentityProviderClient();

// Define function to generate SecretHash
const generateSecretHash = (username, clientId, clientSecret) => {
  return crypto
    .createHmac("SHA256", clientSecret)
    .update(username + clientId)
    .digest("Base64");
};

export const handler = async (event) => {
  try {
    await connectToDB();

    // Parse request body
    const { email } = JSON.parse(event.body);

    // Validate required fields
    if (!email) {
      return {
        statusCode: 400,
        body: JSON.stringify({
          error: "Email is required"
        })
      };
    }

    // Check if user exists in database
    const existingUser = await User.findOne({ email });
    if (!existingUser) {
      return {
        statusCode: 404,
        body: JSON.stringify({
          error: "User not found"
        })
      };
    }

    // Generate secret hash for Cognito
    const secretHash = generateSecretHash(email, CLIENT_ID, CLIENT_SECRET);

    // Prepare input for ForgotPasswordCommand
    const input = {
      ClientId: CLIENT_ID,
      SecretHash: secretHash,
      Username: email
    };

    // Execute forgot password command
    const command = new ForgotPasswordCommand(input);
    const response = await client.send(command);

    // Update user's updated_at timestamp in database
    await User.findOneAndUpdate(
      { email },
      { updated_at: new Date() }
    );

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Password reset code sent successfully. Please check your email for the verification code.",
        data: {
          email: email,
          codeDeliveryDetails: response.CodeDeliveryDetails
        }
      })
    };

  } catch (error) {
    console.error("Forgot password error:", error.message);
    
    // Start with default error message
    let errorMessage = "Failed to initiate password reset";
    let statusCode = 500;

    // Check for user not found
    if (error.name === "UserNotFoundException") {
      errorMessage = "User not found";
      statusCode = 404;
    }

    // Check for invalid parameters
    if (error.name === "InvalidParameterException") {
      errorMessage = "Invalid parameters provided";
      statusCode = 400;
    }

    // Check for too many requests
    if (error.name === "LimitExceededException") {
      errorMessage = "Too many requests. Please try again later";
      statusCode = 429;
    }

    // Check for user account issues
    if (error.name === "NotAuthorizedException") {
      errorMessage = "User account is not in a valid state for password reset";
      statusCode = 403;
    }

    return {
      statusCode: statusCode,
      body: JSON.stringify({
        error: errorMessage,
        details: error.message
      })
    };
  }
};