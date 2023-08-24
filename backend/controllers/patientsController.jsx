const Patient = require('../models/patientsRegistrationModel.jsx');
const Doctor = require("../models/DoctorRegistrationSchema.jsx");

//register patient
const registerPatient = async (req, res) => {
    try {
      const { fullName, email, password, birthDate } = req.body;
      const patient = new Patient({ fullName, email, password, birthDate });
      await patient.save();
      
      res.status(201).json({ message: 'Patient registered successfully' });
    } catch (error) {
      res.status(500).json({ message: 'Failed to register Patient', error });
    }
};

const AddSchedule = async (req, res) => {
  try {
    const patientId = req.params.id;
    const { doctorId, schedule} = req.body;
     

    console.log(patientId, doctorId, schedule);

    await Patient.updateOne({ _id: patientId }, {
      $push: {
        Schedule: {
          doctorId: doctorId,
          Time_Date: schedule,
        }
      }
    }).then((val) => {
      console.log(val);



      Doctor.updateOne(
        { _id: doctorId },
        {
          $pull: {
            Request: {
              RequesterId: patientId
            }
          }
        },
       
      ).then((val) => {
        console.log("Removed requester", val)

        Doctor.updateOne(
          { _id: doctorId },
          {
            $push: {
              Patients: patientId
            }
          },
         
        ).then((val) => {
          console.log("moving requester to patient", val)
   
        }).catch(err => console.log("error removing requester", err));
 
      }).catch(err => console.log("error removing requester", err));
    
      res.json({message: "Schedule Saved Successfully"});
    }).catch((err) => {
      console.log(err);
      res.json({message: "Schedule Saving Failed"});
    
      })
    
  } catch (error) {
    res.status(500).json({ message: 'Failed to Save Schedule', error });
  }
}


module.exports = {
  registerPatient,
  AddSchedule
}