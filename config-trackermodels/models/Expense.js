const mongoose = require('mongoose');

const ExpenseSchema = new mongoose.Schema({
    userId: {
        type: String,
        required: true,
        index: true
    },
    category: {
        type: String,
        required: true,
        trim: true
    },
    title: {
        type: String,
        required: true,
        trim: true
    },
    amount: {
        type: Number,
        required: true,
        min: 0
    },
    date: {
        type: Date,
        required: true
    },
    description: {
        type: String,
        required: false,
        trim: true,
        default: ""
    },
    imageUrl: {
        type: String,
        required: false,
        default: ""
    },
    type: {
        type: String,
        default: "expense"
    }
}, { timestamps: true });

module.exports = mongoose.model('Expense', ExpenseSchema);