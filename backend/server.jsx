require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const connectDb = require('./DbConfig/Configuration.jsx');
const patientRouter = require('./routes/patientsRouter.jsx');
const PORT = process.env.PORT;


const app = express();

//middleware
app.use(express.json());
app.use(cors());

//routes
app.use('/api/users',patientRouter);
//connect to db
connectDb();
//start server
app.listen(PORT,()=>{
    console.log(`server is running on port ${PORT}`);
});