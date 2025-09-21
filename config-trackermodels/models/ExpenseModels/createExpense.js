const { connectToDB } = require('../utils/dbConnection');
const Expense = require('../models/Expense');

exports.lambda_handler = async (event) => {
    try {
        await connectToDB();
        
        const userId = event.requestContext.authorizer.claims.sub;
        const { category, title, amount, date, description, imageUrl } = JSON.parse(event.body);
        
        
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
