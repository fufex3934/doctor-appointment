const Doctor = require("../models/DoctorRegistrationSchema.jsx");
const Patient=require("../models/patientsRegistrationModel.jsx")
const aggregationPipeline = require("../models/aggregation.jsx");
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
  const { overview , requesterId , doctorId }=req.body;
  try {

    console.log(req.body);
   
    Doctor.findOneAndUpdate(
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
  try {
    // Run the aggregation using the imported pipeline
    Doctor.find()
      .populate({
        path: "Request.RequesterId",
        model: "Patient",
      })
      .then((doctors) => {
        // Iterate over each doctor and display their info
        doctors.forEach((doctor) => {
          console.log("Doctor:", doctor.fullName);
          doctor.Request.forEach((request) => {
            console.log("=============",request,"==============")
            console.log("  Requester ID:", request.RequesterId);

            console.log("  Request Overview:", request.Overview);
          });
          console.log("-------------------------");
        });

        // ... rest of the code to send the response to the client
        res.send("");
      })
      .catch((err) => {
        console.error(err);
        res.status(500).send("Internal Server Error");
        res.send("")
      });
  } catch (err) {
    console.error(err);
    res.status(500).send("Internal Server Error");
  }
};


module.exports = {
  getDoctor,
  addRequest,
  getRequest
};
