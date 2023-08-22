const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Patient=require("../models/patientsRegistrationModel.jsx")
const aggregationPipeline = require("../models/aggregation.jsx");
const mongoose = require('mongoose');
const getDoctor = async (req, res) => {
  try {
   
      await Doctor.find({})
        .then((val) => {
          console.log(
             
            val
            );
            res.send(val);
           
        })
        .catch((err) => console.error(err));
      
  } catch (err) {
    console.error(err);
  }
};

const addRequest = async (req, res) => {
  const { overview, requesterId, doctorId } = req.body;
  
  try {

    console.log(overview, requesterId, doctorId);

    await Patient.findOne({ _id: requesterId }).then((val) => console.log("Patient :",val));
    await Doctor.findOne({ _id: doctorId }).then((val) => console.log("Doctor :", val));
    console.log("request overview :", overview);

    console.log(req.body);
   
    await Doctor.updateOne(
      { _id: doctorId },
      {
        $push: {
          Request: {
            RequesterId: requesterId,
            Overview: overview,
          },
        },
      },
      { new: true })
        .then((val) => {
          console.log(
             
            val
            );
            res.send(val);
           
        })
        .catch((err) => console.error(err));
      
  } catch (err) {
    console.error(err);
  }
};
const getRequest = async (req, res) => {
  const doctorId = req.params.id;

  try {
 
    const doctor = await Doctor.findById(doctorId);
    const patientsData = [];
    if (doctor  != null) {
      for (const request of doctor.Request) {
        try {
          const patient = await Patient.findById(request.RequesterId);
          patientsData.push({ "patient": patient, "Overview": request.Overview });
        } catch (err) {
          console.error(err);
        }
      }
    }
    else {
      console.log("null");
    }
    console.log("Patients Data:", patientsData);
    
    res.json(patientsData);
    
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal Server Error");
  }
};
const getPatients = async (req, res) => {
  const doctorId = req.params.id;

  try {
 
    const doctor = await Doctor.findById(doctorId);
    const patientsData = [];
    if (doctor  != null) {
      for (const request of doctor.Patients) {
        try {
          const patient = await Patient.findById(request);
          patientsData.push(  patient);
        } catch (err) {
          console.error(err);
        }
      }
    }
    else {
      console.log("null");
    }
    console.log("===================\nPatients Data:", patientsData);
    
    res.json(patientsData);
    
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal Server Error");
  }
};



module.exports = {
  getDoctor,
  addRequest,
  getRequest,
  getPatients
};
