const { connectToDB } = require('../utils/dbConnection');
const Expense = require('../models/Expense');

exports.lambda_handler = async (event) => {
    try {
        await connectToDB();
        
        const userId = event.requestContext.authorizer.claims.sub;
        const expenseId = event.pathParameters.id;
        
        // Find and delete expense (only user's own expenses)
        const deletedExpense = await Expense.findOneAndDelete({
            _id: expenseId,
            userId
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
                message: 'Expense deleted successfully',
                data: deletedExpense
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