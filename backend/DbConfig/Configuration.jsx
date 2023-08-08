require('dotenv').config();
const mongoose = require('mongoose');

const uri = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/doctor-appointment';

const connectDB = async () => {
  try {
    const connection = await mongoose.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB connected');
    return connection;
  } catch (error) {
    console.log('MongoDB connection error:', error);
    throw error;
  }
};

module.exports = connectDB;
