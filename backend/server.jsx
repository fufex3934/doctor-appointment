require('dotenv').config();
const express = require('express');
const bodyParser=require('body-parser');
const mongoose = require('mongoose');
const WebSocket = require('ws');


const cors = require('cors');
const connectDb = require('./DbConfig/Configuration.jsx');
const patientRouter = require('./routes/patientsRouter.jsx');
const DoctorsRouter=require("./routes/DoctorsRouter.jsx")
const PORT =5000||process.env.PORT;


const app = express();
app.use(bodyParser.json());

const server = new WebSocket.Server({ port: 1234 });
console.log('WebSocket server listening on port '+PORT+1);

server.on('connection', (socket) => {
  console.log('Client connected');

  socket.on('message', (message) => {
    console.log(`Received: ${message}`);
    socket.send(`You said: ${message}`);
  });

  socket.on('close', () => {
    console.log('Client disconnected');
  });
});

//middleware
app.use(express.json());
app.use(cors());

//routes
app.use('/api/users/RegisterPatent',patientRouter);
app.use('/users/Doctor',DoctorsRouter);
//connect to db
connectDb();
//start server
app.listen(PORT,()=>{
    console.log(`server is running on port ${PORT}`);
});