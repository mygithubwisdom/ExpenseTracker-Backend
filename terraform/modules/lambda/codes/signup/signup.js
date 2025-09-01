<<<<<<< HEAD:codes/signup/signup.js
// Import necessary modules
const {
  CognitoIdentityProviderClient,
  SignUpCommand,
} = require("@aws-sdk/client-cognito-identity-provider");
const mongoose = require("mongoose");
const crypto = require("crypto");
=======
// Import necessary modules  
 const {
  CognitoIdentityProviderClient,
  SignUpCommand
} = require("@aws-sdk/client-cognito-identity-provider");
 const mongoose = require('mongoose');
 // import * as mongoose from 'mongoose';
>>>>>>> 293feccddaa2d01b62f7ae7632ea3945a9f4f45b:terraform/modules/lambda/codes/signup/signup.js

// Access environment variables
const CLIENT_ID = process.env.CLIENT_ID;
const CLIENT_SECRET = process.env.CLIENT_SECRET;
const USER_POOL_ID = process.env.USER_POOL_ID;
const MONGO_URI = process.env.MONGODB_URI;

// Logic to connect to DB
let isConnected = false;
const connectToDB = async () => {
  if (isConnected) return;
  try {
    await mongoose.connect(MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    isConnected = true;
    console.log("MongoDB connected successfully");
  } catch (error) {
    console.log("Failed to connect to DB");
    throw error;
  }
};

<<<<<<< HEAD:codes/signup/signup.js
// Define User Schema
const UserSchema = new mongoose.Schema({
=======
// Define User Scehma
const UserSchema = new mongoose.Schema({
  first_name: String,
  last_name: String,
  email: String,
  phone_number: String,
  role: String,
  user_sub: String,
  created_at: {type: Date, default: Date.now},
  updated_at: {type: Date, default: Date.now}
});
// Create user based on schema and prevent model from overwriting with every new deploy
const User = mongoose.models.User || mongoose.model('User', UserSchema);

// Instantiate a new client class
const client = new CognitoIdentityProviderClient();

// Define function to generate SecretHash
const generateSecretHash = (username, clientId, clientSecret) => {
  return crypto
  .createHmac("SHA256", clientSecret)
  .update(username + clientId)
  .digest("Base64")
}

exports.lambda_handler = async (event) => {
  try {
    await connectToDB();

    const {
      first_name,
      last_name,
      email,
      phone_number,
      role,
      password
    } = JSON.parse(event.body);

    // const secretHash = generateSecretHash(email, CLIENT_ID, CLIENT_SECRET);

    const input = {
      ClientId: CLIENT_ID,
     // SecretHash: secretHash,
      Username: email,
      Password: password,
      UserAttributes: [
        {Name: "family_name", Value: last_name},
        {Name: "given_name", Value: first_name},
        {Name: "email", Value: email},
        {Name: "phone_number", Value: phone_number},
        {Name: "custom:role", Value: role}
      ]
    };
    const command = new SignUpCommand(input);
    const response = await client.send(command);

    // Create new user for DB, get user_sub from cognito and save to database
    const user_sub = response.Usersub;
    const user = new User ({
      first_name,
      last_name,
      email,
      phone_number,
      role,
      user_sub
    });

    await user.save();
   
    return {
      statusCode: 201,
      body: JSON.stringify({
        message: "Sign up successful. Pleace check your email for verification code.",
        data: response
      })
    };
  } catch (error) {
      console.error(error.message);
      return {
        statusCode: 400,
        body: JSON.stringify({
          error: error.message || "Sign-up not successful"
        })
      }
  }
};

// Define User Scehma
const UserSchema = new mongooose.Schema({
>>>>>>> 293feccddaa2d01b62f7ae7632ea3945a9f4f45b:terraform/modules/lambda/codes/signup/signup.js
  first_name: String,
  last_name: String,
  email: String,
  phone_number: String,
  role: String,
  user_sub: String,
  created_at: { type: Date, default: Date.now },
  updated_at: { type: Date, default: Date.now },
});

<<<<<<< HEAD:codes/signup/signup.js
// Prevent model overwrite in Lambda warm starts
const User = mongoose.models.User || mongoose.model("User", UserSchema);

// Instantiate Cognito client
const client = new CognitoIdentityProviderClient();

// Generate SecretHash (if needed)
=======
// Instantiate a new client class
const client = new CognitoIdentityProviderClient();

// Define function to generate SecretHash
>>>>>>> 293feccddaa2d01b62f7ae7632ea3945a9f4f45b:terraform/modules/lambda/codes/signup/signup.js
const generateSecretHash = (username, clientId, clientSecret) => {
  return crypto
    .createHmac("SHA256", clientSecret)
    .update(username + clientId)
    .digest("base64");
};

<<<<<<< HEAD:codes/signup/signup.js
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
=======
export const handler = async (event) => {
  try {
    await connectToDB();

    const {
      first_name,
      last_name,
      email,
      phone_number,
      role,
      password
    } = JSON.parse(event.body);

    const secretHash = generateSecretHash(email, CLIENT_ID, CLIENT_SECRET);
>>>>>>> 293feccddaa2d01b62f7ae7632ea3945a9f4f45b:terraform/modules/lambda/codes/signup/signup.js

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

<<<<<<< HEAD:codes/signup/signup.js
    const user_sub = response.UserSub; 
    const user = new User({
=======
    // Create new user for DB, get user_sub from cognito and save to database
    const user_sub = response.Usersub;
    const user = new User ({
>>>>>>> 293feccddaa2d01b62f7ae7632ea3945a9f4f45b:terraform/modules/lambda/codes/signup/signup.js
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
      body: JSON.stringify({
        message:
          "Sign up successful. Please check your email for verification code.",
        data: response,
      }),
    };
  } catch (error) {
    console.error(error.message);
    return {
      statusCode: 400,
      body: JSON.stringify({
        error: error.message || "Sign-up not successful",
      }),
    };
  }
};
