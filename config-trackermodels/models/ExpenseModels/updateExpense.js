const { connectToDB } = require('../utils/dbConnection');
const Expense = require('../models/Expense');

exports.lambda_handler = async (event) => {
    try {
        await connectToDB();
        
        const userId = event.requestContext.authorizer.claims.sub;
        const expenseId = event.pathParameters.id;
        const { category, title, amount, date, description, imageUrl } = JSON.parse(event.body);
        
        // Find and update expense (only user's own expenses)
        const updatedExpense = await Expense.findOneAndUpdate(
            { _id: expenseId, userId },
            {
                category,
                title,
                amount: parseFloat(amount),
                date: new Date(date),
                description: description || "",
                imageUrl: imageUrl || ""
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
            body: JSON.stringify({
                success: true,
                message: 'Expense updated successfully',
                data: updatedExpense
            })
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