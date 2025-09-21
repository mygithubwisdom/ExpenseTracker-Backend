const { connectToDB } = require('../utils/dbConnection');
const Expense = require('../models/Expense');

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
            .sort({ date: -1, createdAt: -1 })
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