const mongoose = require('mongoose');

// Access environment variables
const MONGO_URI = process.env.MONGODB_URI;

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

        const userId = event.requestContext.authorizer.claims.sub;
        const expenseId = event.pathParameters.id;
        
        // Find and delete expense (only user's own expenses)
        const deletedExpense = await Expense.findOneAndDelete({
            _id: expenseId,
            userId: userId
        });
        
        if (!deletedExpense) {
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
                message: 'Expense deleted successfully'
            }
        };
        
    } catch (error) {
        console.error('Delete expense error:', error);
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