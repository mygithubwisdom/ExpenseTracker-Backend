const mongoose = require('mongoose');

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


exports.lambbda_handler = async (event) => {
    try {
        await connectToDB();

        // Safe body parsing (same as your code)
        let body = event.body;
        if (typeof body === "string") {
            body = JSON.parse(body);
        }

        const userId = event.requestContext.authorizer.claims.sub;
        const { category, title, amount, date, description, imageUrl } = body;
        
        // Validation
        if (!category || !title || !amount || !date) {
            return {
                statusCode: 400,
                headers: {
                    'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*'
                },
                body: {
                    success: false,
                    error: 'Category, title, amount, and date are required'
                }
            };
        }
        
        const expense = new Expense({
            userId,
            category,
            title,
            amount: parseFloat(amount),
            date: new Date(date),
            description: description || "",
            imageUrl: imageUrl || "",
            type: "expense"
        });
        
        const savedExpense = await expense.save();
        
        return {
            statusCode: 201,
            headers: {
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*'
            },
            body: {
                success: true,
                message: 'Expense added successfully',
                data: savedExpense
            }
        };
        
    } catch (error) {
        console.error('Create expense error:', error);
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