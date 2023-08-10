require('dotenv').config();
const express = require('express');

const cors = require('cors');
const connectDb = require('./DbConfig/Configuration.jsx');
const patientRouter = require('./routes/patientsRouter.jsx');
const DoctorsRouter=require("./routes/DoctorsRouter.jsx")
const LoginRouter = require("./routes/LoginRouter.jsx")
const PORT = 3000||process.env.PORT;


const app = express();

//middleware
app.use(express.json());
app.use(cors());

//routes
app.use('/api/users',patientRouter);
app.use('/users/Doctor',DoctorsRouter);
app.use('/users/Login',LoginRouter)
//connect to db
connectDb();
//start server
app.listen(PORT,()=>{
    console.log(`server is running on port ${PORT}`);
});