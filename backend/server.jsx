require('dotenv').config();
const express = require('express');

const cors = require('cors');
const connectDb = require('./DbConfig/Configuration.jsx');
const patientRouter = require('./routes/patientsRouter.jsx');
const DoctorsRouter=require("./routes/DoctorsRouter.jsx")
const LoginRouter = require("./routes/LoginRouter.jsx")
const PasswordResetRouter = require("./routes/PasswordResetRouter.jsx")
const EditPatientProfileRouter = require("./routes/EditPatientProfile.jsx")
const EditDoctorProfileRouter = require("./routes/EditDoctorProfile.jsx")
const PORT = 3000||process.env.PORT;


const app = express();

//middleware
app.use(express.json());
app.use(cors());

//routes
app.use('/api/users',patientRouter);
app.use('/users/Doctor',DoctorsRouter);
app.use('/users/Login',LoginRouter)
app.use('/users/ForgotPassword', PasswordResetRouter);
app.use("/users/patient", EditPatientProfileRouter);
app.use("/users/doctor", EditDoctorProfileRouter);
//connect to db
connectDb();
//start server
app.listen(PORT,()=>{
    console.log(`server is running on port ${PORT}`);
});