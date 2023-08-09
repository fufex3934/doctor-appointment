require('dotenv').config();
const mongoose = require('mongoose');

const uri = process.env.MONGO_URI || 'mongodb://127.0.0.1:27017/doctor_appointment_app';

const connectDB = async () => {
  try {
    const connection = await mongoose.connect(uri, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }).then(() => console.log('MongoDB connected')).catch((err) => console.log(err));

    return connection;
  } catch (error) {
    console.log('MongoDB connection error:', error);
    throw error;
  }
};

module.exports = connectDB;
