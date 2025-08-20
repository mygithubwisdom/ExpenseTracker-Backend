// Import necessary modules
import {
  CognitoIdentityProviderClient,
  ConfirmForgotPasswordCommand
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
    const { 
      email, 
      confirmationCode, 
      newPassword 
    } = JSON.parse(event.body);

    // Validate required fields
    if (!email || !confirmationCode || !newPassword) {
      return {
        statusCode: 400,
        body: JSON.stringify({
          error: "Email, confirmation code, and new password are required"
        })
      };
    }

    // Validate password strength (basic validation)
    if (newPassword.length < 8) {
      return {
        statusCode: 400,
        body: JSON.stringify({
          error: "Password must be at least 8 characters long"
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

    // Prepare input for ConfirmForgotPasswordCommand
    const input = {
      ClientId: CLIENT_ID,
      SecretHash: secretHash,
      Username: email,
      ConfirmationCode: confirmationCode,
      Password: newPassword
    };

    // Execute confirm forgot password command
    const command = new ConfirmForgotPasswordCommand(input);
    const response = await client.send(command);

    // Update user's updated_at timestamp in database
    await User.findOneAndUpdate(
      { email },
      { updated_at: new Date() }
    );

    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "Password reset successful. You can now login with your new password.",
        data: {
          email: email,
          passwordResetComplete: true
        }
      })
    };

  } catch (error) {
    console.error("Confirm forgot password error:", error.message);
    
    // Handle common Cognito errors with simple approach
    let errorMessage = "Failed to reset password";
    let statusCode = 500;

    // Check for wrong confirmation code
    if (error.name === "CodeMismatchException") {
      errorMessage = "Invalid confirmation code";
      statusCode = 400;
    }

    // Check for expired code
    if (error.name === "ExpiredCodeException") {
      errorMessage = "Confirmation code has expired. Please request a new password reset";
      statusCode = 400;
    }

    // Check for weak password
    if (error.name === "InvalidPasswordException") {
      errorMessage = "Password does not meet requirements";
      statusCode = 400;
    }

    // Check for user not found
    if (error.name === "UserNotFoundException") {
      errorMessage = "User not found";
      statusCode = 404;
    }

    // Check for too many attempts
    if (error.name === "LimitExceededException") {
      errorMessage = "Too many attempts. Please try again later";
      statusCode = 429;
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