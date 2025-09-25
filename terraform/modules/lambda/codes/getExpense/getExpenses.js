const mongoose = require('mongoose');

const MONGO_URI = process.env.MONGODB_URI;

// Logic to connect to DB (same as signup code)
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
        const queryParams = event.queryStringParameters || {};
        
        // Build filter object
        let filter = { userId };
        
        // Add optional filters
        if (queryParams.category) {
            filter.category = queryParams.category;
        }
        
        if (queryParams.startDate && queryParams.endDate) {
            filter.date = {
                $gte: new Date(queryParams.startDate),
                $lte: new Date(queryParams.endDate)
            };
        }
        
        // Get expenses with sorting
        const expenses = await Expense.find(filter)
            .sort({ date: -1, created_at: -1 })
            .lean();
        
        // Calculate total
        const totalAmount = expenses.reduce((sum, expense) => sum + expense.amount, 0);
        
        return {
            statusCode: 200,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: {
                success: true,
                data: expenses,
                summary: {
                    total: totalAmount,
                    count: expenses.length
                }
            }
        };
        
    } catch (error) {
        console.error('Get expenses error:', error);
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