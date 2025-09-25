const mongoose = require('mongoose');

// Access environment variables
const MONGO_URI = process.env.MONGODB_URI;

// Logic to connect to DB (same as your signup code)
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

// Define Expense Schema (same pattern as User schema)
const ExpenseSchema = new mongoose.Schema({
    userId: String,
    category: String,
    title: String,
    amount: Number,
    date: Date,
    description: String,
    imageUrl: String,
    type: { type: String, default: "expense" },
    created_at: { type: Date, default: Date.now },
    updated_at: { type: Date, default: Date.now },
});

// Prevent model overwrite in Lambda warm starts
const Expense = mongoose.models.Expense || mongoose.model("Expense", ExpenseSchema);


exports.lambda_handler = async (event) => {
    try {
        await connectToDB();

        // Safe body parsing (same as your code)
        let body = event.body;
        if (typeof body === "string") {
            body = JSON.parse(body);
        }
        
        const userId = event.requestContext.authorizer.claims.sub;
        const expenseId = event.pathParameters.id;
        const { category, title, amount, date, description, imageUrl } = body;
        
        // Find and update expense (only user's own expenses)
        const updatedExpense = await Expense.findOneAndUpdate(
            { _id: expenseId, userId },
            {
                category,
                title,
                amount: parseFloat(amount),
                date: new Date(date),
                description: description || "",
                imageUrl: imageUrl || "",
                updated_at: new Date()
            },
            { new: true, runValidators: true }
        );
        
        if (!updatedExpense) {
            return {
                statusCode: 404,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*'
                },
                body: {
                    success: false,
                    error: 'Expense not found'
                }
            };
        }
        
        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: {
                success: true,
                message: 'Expense updated successfully',
                data: updatedExpense
            }
        };
        
    } catch (error) {
        console.error('Update expense error:', error);
        return {
            statusCode: 500,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: {
                success: false,
                error: error.message
            }
        };
    }
};